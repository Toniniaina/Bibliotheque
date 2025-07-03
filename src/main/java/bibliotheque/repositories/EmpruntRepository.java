package bibliotheque.repositories;

import bibliotheque.entities.Emprunt;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmpruntRepository extends JpaRepository<Emprunt, Integer> {
}