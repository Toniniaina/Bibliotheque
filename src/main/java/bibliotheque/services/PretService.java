package bibliotheque.services;

import bibliotheque.entities.*;
import bibliotheque.models.EmpruntDTO;
import bibliotheque.repositories.*;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.time.LocalDate;
import java.util.List;

@Service
@AllArgsConstructor
public class PretService {
    private final EmpruntRepository empruntRepository;
    private final AdherentRepository adherentRepository;
    private final PenaliteRepository penaliteRepository;
    private final ExemplaireRepository exemplaireRepository;
    private final PenaliteService penaliteService;
    private final MvtEmpruntRepository mvtEmpruntRepository; // Ajout

    @Transactional // Ajout de la gestion transactionnelle
    public void creerPret(EmpruntDTO dto, Instant datePret, Instant dateRetourPrevue) {
        // Vérification de l'adhérent
        Adherent adherent = adherentRepository.findById(dto.getAdherentId())
                .orElseThrow(() -> new IllegalArgumentException("Adhérent introuvable."));

        // Vérification de l'exemplaire
        Exemplaire exemplaire = exemplaireRepository.findById(dto.getExemplaires().get(0).getId())
                .orElseThrow(() -> new IllegalArgumentException("Exemplaire introuvable."));

        if (exemplaire.getQuantite() == null || exemplaire.getQuantite() <= 0) {
            throw new IllegalArgumentException("Aucun exemplaire disponible pour ce livre.");
        }

        // Vérification du quota d'emprunt
        int quota = adherent.getIdProfil().getQuotaEmpruntsSimultanes();
        long empruntsEnCours = empruntRepository.findAll().stream()
                .filter(e -> e.getIdAdherent().getId().equals(adherent.getId()))
                .filter(e -> {
                    // Un emprunt est "en cours" si pas encore retourné ou perdu
                    return e.getDateRetourPrevue() == null || e.getDateRetourPrevue().isAfter(Instant.now());
                })
                .count();

        if (empruntsEnCours >= quota) {
            throw new IllegalArgumentException("Quota d'emprunts simultanés atteint pour ce profil.");
        }

        // Vérification pénalité en cours basée sur la dernière pénalité
        LocalDate dateDebutPret = LocalDate.ofInstant(datePret, java.time.ZoneId.systemDefault());
        LocalDate dateFinDernierePenalite = penaliteService.getDateFinDernierePenalite(adherent.getId());
        if (dateFinDernierePenalite != null && !dateFinDernierePenalite.isBefore(dateDebutPret)) {
            throw new IllegalArgumentException("Cet adhérent a une pénalité en cours jusqu'au " + dateFinDernierePenalite + " et ne peut pas faire de prêt à la date demandée.");
        }

        // Création du prêt (emprunt)
        Emprunt emprunt = new Emprunt();
        // Ne pas setter l'id, laisser la base l'auto-générer
        emprunt.setIdExemplaire(exemplaire);
        emprunt.setIdAdherent(adherent);
        emprunt.setIdTypeEmprunt(dto.getIdTypeEmprunt());
        emprunt.setDateEmprunt(datePret);
        emprunt.setDateRetourPrevue(dateRetourPrevue);
        emprunt = empruntRepository.save(emprunt);

        // Insertion dans MvtEmprunt (statut 1 = "emprunté")
        MvtEmprunt mvt = new MvtEmprunt();
        mvt.setIdEmprunt(emprunt);
        // Statut 1 = "emprunté" (doit exister dans la table Statuts_Emprunt)
        StatutsEmprunt statutEmprunte = new StatutsEmprunt();
        statutEmprunte.setId(1);
        mvt.setIdStatutNouveau(statutEmprunte);
        mvt.setDateMouvement(datePret);
        mvtEmpruntRepository.save(mvt);

        // Mise à jour du stock
        exemplaire.setQuantite(exemplaire.getQuantite() - 1);
        exemplaireRepository.save(exemplaire);
    }
}