package bibliotheque.repositories;

import bibliotheque.entities.Abonnement;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AbonnementRepository extends JpaRepository<Abonnement, Integer> {
    List<Abonnement> findByIdAdherent_Id(Integer idAdherent);

}