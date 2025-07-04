package bibliotheque.repositories;

import bibliotheque.entities.StatutsReservation;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StatutsReservationRepository extends JpaRepository<StatutsReservation, Integer> {
}