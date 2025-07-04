package bibliotheque.repositories;

import bibliotheque.entities.MvtReservation;
import bibliotheque.entities.Reservation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MvtReservationRepository extends JpaRepository<MvtReservation, Integer> {
    MvtReservation findTopByIdReservationOrderByDateMouvementDesc(Reservation reservation);
}