package bibliotheque.repositories;

import bibliotheque.entities.TypeEmprunt;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TypeEmpruntRepository extends JpaRepository<TypeEmprunt, Integer> {
}