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
        LocalDate dateDebutPenalite = dateRetourReelle;

        if (dto.getAdherent() != null) {
            List<Penalite> penalitesExistantes = penaliteRepository.findAll();
            LocalDate dateFin = null;

            for (Penalite p : penalitesExistantes) {
                if (p.getIdAdherent() != null &&
                        p.getIdAdherent().getId().equals(dto.getAdherent().getId())) {

                    LocalDate finPenalite = p.getDateDebut().plusDays(p.getJour());
                    if (finPenalite.isAfter(LocalDate.now())) {
                        if (dateFin == null || finPenalite.isAfter(dateFin)) {
                            dateFin = finPenalite;
                        }
                    }
                }
            }
            if (dateFin != null) {
                dateDebutPenalite = dateFin.plusDays(1);
            }
        }

        long joursRetard = dateRetourPrevue.until(dateRetourReelle).getDays();

        Penalite p = new Penalite();
        p.setIdEmprunt(emprunt);
        p.setIdAdherent(dto.getAdherent());
        p.setDateDebut(dateDebutPenalite);
        // Utilisation automatique du nb_jour_penalite du profil adhérent si non fourni
        Integer nbJourPenaliteProfil = null;
        if (dto.getAdherent() != null && dto.getAdherent().getIdProfil() != null) {
            nbJourPenaliteProfil = dto.getAdherent().getIdProfil().getNbJourPenalite();
        }
        if (dto.getJour() != null) {
            p.setJour(dto.getJour());
        } else if (nbJourPenaliteProfil != null && nbJourPenaliteProfil > 0) {
            p.setJour(nbJourPenaliteProfil);
        } else {
            p.setJour((int) joursRetard);
        }
        p.setRaison(dto.getRaison());

        penaliteRepository.save(p);
    }

    public LocalDate getDateFinDernierePenalite(Integer adherentId) {
        List<Penalite> penalites = penaliteRepository.findAll();
        Penalite derniere = penalites.stream()
                .filter(p -> p.getIdAdherent() != null && p.getIdAdherent().getId().equals(adherentId))
                .max((p1, p2) -> p1.getDateDebut().compareTo(p2.getDateDebut()))
                .orElse(null);

        if (derniere == null) return null;
        return derniere.getDateDebut().plusDays(derniere.getJour());
    }
}