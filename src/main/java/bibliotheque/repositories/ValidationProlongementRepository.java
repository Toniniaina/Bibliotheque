package bibliotheque.repositories;

import bibliotheque.entities.Prolongement;
import bibliotheque.entities.ValidationProlongement;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ValidationProlongementRepository extends JpaRepository<ValidationProlongement, Integer> {
    List<ValidationProlongement> findByIdProlongement(Prolongement prolongement);
}