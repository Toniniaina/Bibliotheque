package bibliotheque.repositories;

import bibliotheque.entities.Prolongement;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProlongementRepository extends JpaRepository<Prolongement, Integer> {
}