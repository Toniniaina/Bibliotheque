package bibliotheque.services;

import bibliotheque.entities.Livre;
import bibliotheque.repositories.LivreRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class LivreService {
    private final LivreRepository livreRepository;
    public List<Livre> getAll(){
        return livreRepository.findAll();
    }
}
