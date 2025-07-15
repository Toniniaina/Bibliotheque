package bibliotheque.repositories;

import bibliotheque.entities.Exemplaire;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ExemplaireRepository extends JpaRepository<Exemplaire, Integer> {
    Exemplaire findByIdLivreId(Integer idLivre);
}