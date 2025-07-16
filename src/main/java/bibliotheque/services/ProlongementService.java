package bibliotheque.services;

import bibliotheque.entities.Prolongement;
import bibliotheque.entities.ValidationProlongement;
import bibliotheque.repositories.ProlongementRepository;
import bibliotheque.repositories.ValidationProlongementRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import bibliotheque.entities.Emprunt;

@Service
@AllArgsConstructor
public class ProlongementService {
    private final ProlongementRepository prolongementRepository;
    private final ValidationProlongementRepository validationProlongementRepository;

    public List<Prolongement> getProlongementsNonValides() {
        return prolongementRepository.findAll().stream()
                .filter(p -> validationProlongementRepository.findByIdProlongement(p).isEmpty())
                .toList();
    }

    public void validerProlongement(Integer idProlongement, boolean valide) {
        Prolongement prolongement = prolongementRepository.findById(idProlongement)
                .orElseThrow(() -> new IllegalArgumentException("Prolongement non trouvé"));

        // Vérification du quota de prolongements validés pour l'adhérent
        Emprunt emprunt = prolongement.getIdEmprunt();
        if (emprunt != null && emprunt.getIdAdherent() != null) {
            Integer adherentId = emprunt.getIdAdherent().getId();
            Integer quotaProlongement = emprunt.getIdAdherent().getIdProfil().getProlongementPret();
            if (quotaProlongement != null) {
                // On compte tous les prolongements validés pour cet adhérent
                long nbProlongementsValides = prolongementRepository.findAll().stream()
                    .filter(p -> p.getIdEmprunt() != null && p.getIdEmprunt().getIdAdherent() != null &&
                        p.getIdEmprunt().getIdAdherent().getId().equals(adherentId))
                    .filter(p -> {
                        List<ValidationProlongement> validations = validationProlongementRepository.findByIdProlongement(p);
                        return validations != null && validations.stream().anyMatch(v -> Boolean.TRUE.equals(v.getValide()));
                    })
                    .count();
                if (nbProlongementsValides >= quotaProlongement) {
                    throw new IllegalArgumentException("Quota de prolongements atteints pour cet adhérent. Impossible de valider un nouveau prolongement.");
                }
            }
        }

        ValidationProlongement validation = new ValidationProlongement();
        validation.setIdProlongement(prolongement);
        validation.setDateValidation(LocalDate.now());
        validation.setValide(valide);

        validationProlongementRepository.save(validation);
    }

    public void createProlongement(Emprunt emprunt, LocalDate dateFin) {
        if (emprunt == null || emprunt.getIdAdherent() == null) {
            throw new IllegalArgumentException("Emprunt ou adhérent introuvable pour le prolongement.");
        }
        Integer adherentId = emprunt.getIdAdherent().getId();
        Integer quotaProlongement = emprunt.getIdAdherent().getIdProfil().getProlongementPret();
        if (quotaProlongement != null) {
            long nbProlongementsValides = prolongementRepository.findAll().stream()
                .filter(p -> p.getIdEmprunt() != null && p.getIdEmprunt().getIdAdherent() != null &&
                    p.getIdEmprunt().getIdAdherent().getId().equals(adherentId))
                .filter(p -> {
                    List<ValidationProlongement> validations = validationProlongementRepository.findByIdProlongement(p);
                    return validations != null && validations.stream().anyMatch(v -> Boolean.TRUE.equals(v.getValide()));
                })
                .count();
            if (nbProlongementsValides >= quotaProlongement) {
                throw new IllegalArgumentException("Quota de prolongements atteints pour cet adhérent. Impossible de créer un nouveau prolongement.");
            }
        }
        Prolongement prolongement = new Prolongement();
        prolongement.setIdEmprunt(emprunt);
        prolongement.setDateFin(dateFin);
        prolongement.setDateProlongement(LocalDate.now());
        prolongementRepository.save(prolongement);
    }
}
