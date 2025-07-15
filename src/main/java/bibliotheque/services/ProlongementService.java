package bibliotheque.services;

import bibliotheque.entities.Prolongement;
import bibliotheque.entities.ValidationProlongement;
import bibliotheque.repositories.ProlongementRepository;
import bibliotheque.repositories.ValidationProlongementRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

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

        ValidationProlongement validation = new ValidationProlongement();
        validation.setIdProlongement(prolongement);
        validation.setDateValidation(LocalDate.now());
        validation.setValide(valide);

        validationProlongementRepository.save(validation);
    }
}
