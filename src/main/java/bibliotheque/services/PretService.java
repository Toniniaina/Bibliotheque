package bibliotheque.services;

import bibliotheque.entities.*;
import bibliotheque.models.EmpruntDTO;
import bibliotheque.repositories.*;
import bibliotheque.services.EmpruntService;
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
    private final MvtEmpruntRepository mvtEmpruntRepository;
    private final AbonnementRepository abonnementRepository;
    private final EmpruntService empruntService;

    @Transactional
    public void creerPret(EmpruntDTO dto, Instant datePret, Instant dateRetourPrevue) {
        Adherent adherent = adherentRepository.findById(dto.getAdherentId())
                .orElseThrow(() -> new IllegalArgumentException("Adhérent introuvable."));
        Exemplaire exemplaire = exemplaireRepository.findById(dto.getExemplaires().get(0).getId())
                .orElseThrow(() -> new IllegalArgumentException("Exemplaire introuvable."));
        LocalDate datePretLocal = LocalDate.ofInstant(datePret, java.time.ZoneId.systemDefault());
        boolean abonnementActif = abonnementRepository.findByIdAdherent_Id(adherent.getId()).stream()
                .anyMatch(ab -> !ab.getDateDebut().isAfter(datePretLocal) && !ab.getDateFin().isBefore(datePretLocal));
        if (!abonnementActif) {
            throw new IllegalArgumentException("L'adhérent n'a pas d'abonnement actif à la date du prêt.");
        }

        if (exemplaire.getQuantite() == null || exemplaire.getQuantite() <= 0) {
            throw new IllegalArgumentException("Aucun exemplaire disponible pour ce livre.");
        }
        int quota = adherent.getIdProfil().getQuotaEmpruntsSimultanes();
        // Correction : utiliser la vraie logique d'emprunts non rendus
        long empruntsNonRendus = empruntService.getEmpruntsNonRendusByAdherentId(adherent.getId()).size();
        if (empruntsNonRendus >= quota) {
            throw new IllegalArgumentException("Quota d'emprunts simultanés atteint pour ce profil.");
        }
        LocalDate dateDebutPret = datePretLocal;
        LocalDate dateFinDernierePenalite = penaliteService.getDateFinDernierePenalite(adherent.getId());
        if (dateFinDernierePenalite != null && !dateFinDernierePenalite.isBefore(dateDebutPret)) {
            throw new IllegalArgumentException("Cet adhérent a une pénalité en cours jusqu'au " + dateFinDernierePenalite + " et ne peut pas faire de prêt à la date demandée.");
        }
        // Vérification de la durée maximale de prêt autorisée par le profil
        Integer joursPretMax = adherent.getIdProfil().getJoursPret();
        if (joursPretMax != null) {
            long joursDemandes = java.time.temporal.ChronoUnit.DAYS.between(datePretLocal, LocalDate.ofInstant(dateRetourPrevue, java.time.ZoneId.systemDefault()));
            if (joursDemandes > joursPretMax) {
                throw new IllegalArgumentException("La durée du prêt demandée (" + joursDemandes + " jours) dépasse la limite autorisée pour ce profil (" + joursPretMax + " jours).");
            }
        }
        Emprunt emprunt = new Emprunt();
        emprunt.setIdExemplaire(exemplaire);
        emprunt.setIdAdherent(adherent);
        emprunt.setIdTypeEmprunt(dto.getIdTypeEmprunt());
        emprunt.setDateEmprunt(datePret);
        emprunt.setDateRetourPrevue(dateRetourPrevue);
        emprunt = empruntRepository.save(emprunt);
        MvtEmprunt mvt = new MvtEmprunt();
        mvt.setIdEmprunt(emprunt);
        StatutsEmprunt statutEmprunte = new StatutsEmprunt();
        statutEmprunte.setId(1);
        mvt.setIdStatutNouveau(statutEmprunte);
        mvt.setDateMouvement(datePret);
        mvtEmpruntRepository.save(mvt);
        exemplaire.setQuantite(exemplaire.getQuantite() - 1);
        exemplaireRepository.save(exemplaire);
    }
}