package bibliotheque.repositories;

import bibliotheque.entities.JoursFery;
import org.springframework.data.jpa.repository.JpaRepository;

public interface JoursFeryRepository extends JpaRepository<JoursFery, java.time.LocalDate> {
} 