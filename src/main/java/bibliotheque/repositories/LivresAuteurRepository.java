package bibliotheque.repositories;

import bibliotheque.entities.LivresAuteur;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface LivresAuteurRepository extends JpaRepository<LivresAuteur, Integer> {
    List<LivresAuteur> findByIdLivreId(Integer livreId);
}

