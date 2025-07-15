package bibliotheque.repositories;

import bibliotheque.entities.LivresCategory;
import bibliotheque.entities.LivresCategoryId;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LivresCategoryRepository extends JpaRepository<LivresCategory, LivresCategoryId> {
List<LivresCategory> findByIdLivreId(Integer livreId);
}