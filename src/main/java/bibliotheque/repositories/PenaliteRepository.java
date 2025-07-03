package bibliotheque.repositories;

import bibliotheque.entities.Penalite;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PenaliteRepository extends JpaRepository<Penalite, Integer> {
}