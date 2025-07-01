package bibliotheque.services;

import bibliotheque.entities.Adherent;
import bibliotheque.entities.Bibliothecaire;
import bibliotheque.entities.Utilisateur;
import bibliotheque.models.UtilisateurDto;
import bibliotheque.repositories.UtilisateurRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UtilisateurService {
    private final UtilisateurRepository utilisateurRepository;
    private final AdherentService adherentService;
    private final BibliothecaireService bibliothecaireService;
    private final PasswordEncoder passwordEncoder;

    public boolean signup(UtilisateurDto dto, boolean isAdherent) {
        if (utilisateurRepository.findByEmail(dto.getEmail()).isPresent()) {
            return false; // email déjà utilisé
        }
        Utilisateur utilisateur = new Utilisateur();
        utilisateur.setEmail(dto.getEmail());
        utilisateur.setMotDePasseHash(passwordEncoder.encode(dto.getMdp()));
        utilisateur.setDateCreation(Instant.now());
        utilisateur = utilisateurRepository.save(utilisateur);

        if (isAdherent) {
            adherentService.createAdherent(utilisateur, dto);
        } else {
            bibliothecaireService.createBibliothecaire(utilisateur, dto);
        }
        return true;
    }

    public Object login(UtilisateurDto dto) {
        Optional<Utilisateur> opt = utilisateurRepository.findByEmail(dto.getEmail());
        if (opt.isEmpty()) return null;
        Utilisateur utilisateur = opt.get();
        if (!passwordEncoder.matches(dto.getMdp(), utilisateur.getMotDePasseHash())) {
            return null;
        }
        Optional<Adherent> adherent = adherentService.findByUtilisateur(utilisateur);
        if (adherent.isPresent()) return adherent.get();

        Optional<Bibliothecaire> bibliothecaire = bibliothecaireService.findByUtilisateur(utilisateur);
        return bibliothecaire.orElse(null);
    }
}