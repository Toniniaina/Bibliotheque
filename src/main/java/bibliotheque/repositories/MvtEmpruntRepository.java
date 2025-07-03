package bibliotheque.repositories;

import bibliotheque.entities.Emprunt;
import bibliotheque.entities.MvtEmprunt;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface MvtEmpruntRepository extends JpaRepository<MvtEmprunt, Integer> {
    List<MvtEmprunt> findByIdEmpruntOrderByDateMouvementDesc(Emprunt emprunt);
}
