package bibliotheque.services;

import bibliotheque.entities.Abonnement;
import bibliotheque.entities.Adherent;
import bibliotheque.models.AbonnementDTO;
import bibliotheque.repositories.AbonnementRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class AbonnementService {
    private final AbonnementRepository abonnementRepository;
    private final AdherentService adherentService;
    public void createAbonnement(AbonnementDTO dto) {
        Adherent adherent = adherentService.getAdherentById(dto.getAdherent());
        List<Abonnement> abonnementsExistants = abonnementRepository.findByIdAdherent_Id(dto.getAdherent());

        for (Abonnement existing : abonnementsExistants) {
            boolean chevauche = !dto.getDateFin().isBefore(existing.getDateDebut()) &&
                    !dto.getDateDebut().isAfter(existing.getDateFin());

            if (chevauche) {
                throw new IllegalArgumentException("L’abonnement chevauche un abonnement existant pour cet adhérent.");
            }
        }

        Abonnement abo = new Abonnement();
        abo.setDateDebut(dto.getDateDebut());
        abo.setDateFin(dto.getDateFin());
        abo.setIdAdherent(adherent);

        abonnementRepository.save(abo);
    }


}
