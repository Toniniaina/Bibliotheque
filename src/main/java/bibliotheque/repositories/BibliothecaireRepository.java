package bibliotheque.repositories;

import bibliotheque.entities.Bibliothecaire;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BibliothecaireRepository extends JpaRepository<Bibliothecaire, Integer> {
}