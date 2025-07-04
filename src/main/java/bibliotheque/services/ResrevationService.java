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
    private final PenaliteService penaliteService;
    private final AbonnementRepository abonnementRepository;
    private final MvtReservationRepository mvtReservationRepository;

    public void createReservation(Integer idExemplaire, Integer adherentId, LocalDate dateExpiration) {
        Exemplaire exemplaire = exemplaireRepository.findById(idExemplaire)
                .orElseThrow(() -> new IllegalArgumentException("Exemplaire introuvable"));
        Adherent adherent = adherentRepository.findById(adherentId)
                .orElseThrow(() -> new IllegalArgumentException("Adhérent introuvable"));

        // Vérification pénalité à la date d'expiration de la réservation
        LocalDate dateFinPenalite = penaliteService.getDateFinDernierePenalite(adherentId);
        if (dateFinPenalite != null && !dateFinPenalite.isBefore(dateExpiration)) {
            throw new IllegalArgumentException("Vous avez une pénalité en cours à la date d'expiration de la réservation.");
        }

        // Vérification abonnement actif à la date d'expiration de la réservation
        boolean abonnementActif = abonnementRepository.findByIdAdherent_Id(adherentId).stream()
                .anyMatch(ab -> !ab.getDateDebut().isAfter(dateExpiration) && !ab.getDateFin().isBefore(dateExpiration));
        if (!abonnementActif) {
            throw new IllegalArgumentException("Votre abonnement sera expiré à la date d'expiration de la réservation.");
        }

        StatutsReservation statut = statutsReservationRepository.findById(1)
                .orElseThrow(() -> new IllegalArgumentException("Statut de réservation 'à valider' introuvable"));

        Reservation resa = new Reservation();
        resa.setIdLivre(exemplaire.getIdLivre());
        resa.setIdAdherent(adherent);
        resa.setDateDemande(java.time.Instant.now());
        resa.setDateExpiration(dateExpiration);

        resa = reservationRepository.save(resa);

        // Insertion dans MvtReservation avec statut "à valider" (id=1)
        MvtReservation mvt = new MvtReservation();
        mvt.setIdReservation(resa);
        mvt.setIdStatutNouveau(statut);
        mvt.setDateMouvement(java.time.Instant.now());
        mvtReservationRepository.save(mvt);
    }
}
