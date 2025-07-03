package bibliotheque.services;

import bibliotheque.entities.*;
import bibliotheque.models.PenaliteDTO;
import bibliotheque.repositories.EmpruntRepository;
import bibliotheque.repositories.MvtEmpruntRepository;
import bibliotheque.repositories.PenaliteRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.List;

@Service
@AllArgsConstructor
public class PenaliteService {
    private final PenaliteRepository penaliteRepository;
    private final MvtEmpruntRepository mvtEmpruntRepository;
    private final EmpruntRepository empruntRepository;
    public List<Penalite> getAllPenalites() {
        return penaliteRepository.findAll();
    }

    public void createPenalite(PenaliteDTO dto) {
        Integer empruntId = dto.getEmprunt() != null ? dto.getEmprunt().getId() : null;

        if (empruntId == null) {
            throw new IllegalArgumentException("ID Emprunt non trouvé.");
        }

        Emprunt emprunt = empruntRepository.findById(empruntId)
                .orElseThrow(() -> new IllegalArgumentException("Emprunt non trouvé avec l'ID: " + empruntId));

        if (emprunt.getDateRetourPrevue() == null) {
            throw new IllegalArgumentException("La date de retour prévue de l'emprunt est manquante.");
        }

        MvtEmprunt dernier = mvtEmpruntRepository
                .findByIdEmpruntOrderByDateMouvementDesc(emprunt)
                .stream()
                .findFirst()
                .orElse(null);

        if (dernier == null) {
            throw new IllegalArgumentException("Aucun mouvement trouvé pour cet emprunt.");
        }

        int statut = dernier.getIdStatutNouveau().getId();
        if (statut != 2 && statut != 4) {
            throw new IllegalArgumentException("Cet emprunt n'est pas retourné ou perdu.");
        }

        // Date de retour effective du livre
        LocalDate dateRetourReelle = dernier.getDateMouvement()
                .atZone(ZoneId.systemDefault())
                .toLocalDate();

        LocalDate dateRetourPrevue = emprunt.getDateRetourPrevue()
                .atZone(ZoneId.systemDefault())
                .toLocalDate();

        if (!dateRetourReelle.isAfter(dateRetourPrevue)) {
            throw new IllegalArgumentException("La date de retour réelle (" + dateRetourReelle +
                    ") n'est pas postérieure à la date de retour prévue (" + dateRetourPrevue + ").");
        }

        // Vérifier s'il y a des pénalités en cours pour cet adhérent
        LocalDate dateDebutPenalite = dateRetourReelle;

        if (dto.getAdherent() != null) {
            List<Penalite> penalitesExistantes = penaliteRepository.findAll();
            LocalDate dateFin = null;

            for (Penalite p : penalitesExistantes) {
                if (p.getIdAdherent() != null &&
                        p.getIdAdherent().getId().equals(dto.getAdherent().getId())) {

                    LocalDate finPenalite = p.getDateDebut().plusDays(p.getJour());

                    // Si la pénalité se termine après aujourd'hui, elle est encore active
                    if (finPenalite.isAfter(LocalDate.now())) {
                        if (dateFin == null || finPenalite.isAfter(dateFin)) {
                            dateFin = finPenalite;
                        }
                    }
                }
            }

            // Si il y a une pénalité en cours, la nouvelle commence le lendemain de la fin
            if (dateFin != null) {
                dateDebutPenalite = dateFin.plusDays(1);
            }
        }

        // Calculer le nombre de jours de retard
        long joursRetard = dateRetourPrevue.until(dateRetourReelle).getDays();

        Penalite p = new Penalite();
        p.setIdEmprunt(emprunt);
        p.setIdAdherent(dto.getAdherent());
        p.setDateDebut(dateDebutPenalite);
        p.setJour(dto.getJour() != null ? dto.getJour() : (int) joursRetard);
        p.setRaison(dto.getRaison());

        penaliteRepository.save(p);
    }
}