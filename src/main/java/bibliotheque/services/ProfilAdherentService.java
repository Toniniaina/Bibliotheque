package bibliotheque.services;

import bibliotheque.entities.ProfilsAdherent;
import bibliotheque.repositories.ProfilsAdherentRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ProfilAdherentService {
    private final ProfilsAdherentRepository profilsAdherentRepository;
    public List<ProfilsAdherent> getAllProfils() {
        return profilsAdherentRepository.findAll();
    }
}
