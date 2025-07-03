package bibliotheque.services;

import bibliotheque.entities.Adherent;
import bibliotheque.entities.ProfilsAdherent;
import bibliotheque.entities.Utilisateur;
import bibliotheque.models.UtilisateurDto;
import bibliotheque.repositories.AdherentRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AdherentService {
    private final AdherentRepository adherentRepository;

    public Optional<Adherent> findByUtilisateur(Utilisateur utilisateur) {
        return adherentRepository.findAll().stream()
                .filter(a -> a.getIdUtilisateur().getId().equals(utilisateur.getId()))
                .findFirst();
    }

    public Adherent createAdherent(Utilisateur utilisateur, UtilisateurDto dto) {
        Adherent adherent = new Adherent();
        adherent.setIdUtilisateur(utilisateur);
        adherent.setNom(dto.getNom());
        adherent.setPrenom(dto.getPrenom());
        // adherent.setTelephone(dto.getTelephone());
        adherent.setDateInscription(dto.getDatecreation() != null ? dto.getDatecreation() : Instant.now().atZone(java.time.ZoneId.systemDefault()).toLocalDate());
        adherent.setDateNaissance(dto.getDatenaissance());
        ProfilsAdherent profil = new ProfilsAdherent();
        profil.setId(dto.getIdProfilAdherent());
        adherent.setIdProfil(profil);

        return adherentRepository.save(adherent);
    }
    public List<Adherent> getAllAdherents() {
        return adherentRepository.findAll();
    }
    public Adherent getAdherentById(Integer id) {
        return adherentRepository.findById(id).orElse(null);
    }

}
