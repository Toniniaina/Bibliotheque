package bibliotheque.services;

import bibliotheque.entities.Bibliothecaire;
import bibliotheque.entities.Utilisateur;
import bibliotheque.models.UtilisateurDto;
import bibliotheque.repositories.BibliothecaireRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class BibliothecaireService {
    private final BibliothecaireRepository bibliothecaireRepository;

    public Optional<Bibliothecaire> findByUtilisateur(Utilisateur utilisateur) {
        return bibliothecaireRepository.findAll().stream()
                .filter(b -> b.getIdUtilisateur().getId().equals(utilisateur.getId()))
                .findFirst();
    }

    public Bibliothecaire createBibliothecaire(Utilisateur utilisateur, UtilisateurDto dto) {
        Bibliothecaire bibliothecaire = new Bibliothecaire();
        bibliothecaire.setIdUtilisateur(utilisateur);
        bibliothecaire.setNom(dto.getNom());
        bibliothecaire.setPrenom(dto.getPrenom());
        return bibliothecaireRepository.save(bibliothecaire);
    }
}
