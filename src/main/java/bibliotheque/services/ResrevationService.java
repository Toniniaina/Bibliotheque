package bibliotheque.services;

import bibliotheque.entities.*;
import bibliotheque.repositories.*;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDate;

@Service
@AllArgsConstructor
public class ResrevationService {
    private final ReservationRepository reservationRepository;
    private final LivreRepository livreRepository;
    private final AdherentRepository adherentRepository;
    private final StatutsReservationRepository statutsReservationRepository;
    private final ExemplaireRepository exemplaireRepository;

    public void createReservation(Integer idExemplaire, Integer adherentId, LocalDate dateExpiration) {
        Exemplaire exemplaire = exemplaireRepository.findById(idExemplaire)
                .orElseThrow(() -> new IllegalArgumentException("Exemplaire introuvable"));
        Adherent adherent = adherentRepository.findById(adherentId)
                .orElseThrow(() -> new IllegalArgumentException("Adhérent introuvable"));
        StatutsReservation statut = statutsReservationRepository.findById(1)
                .orElseThrow(() -> new IllegalArgumentException("Statut de réservation 'à valider' introuvable"));

        Reservation resa = new Reservation();
        resa.setIdLivre(exemplaire.getIdLivre());
        resa.setIdAdherent(adherent);
        resa.setIdStatut(statut);
        resa.setDateDemande(Instant.now());
        resa.setDateExpiration(dateExpiration);

        reservationRepository.save(resa);
    }
}
