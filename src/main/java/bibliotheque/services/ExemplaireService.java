package bibliotheque.services;

import bibliotheque.dto.ExemplaireDTO;
import bibliotheque.entities.Exemplaire;
import bibliotheque.repositories.ExemplaireRepository;
import bibliotheque.repositories.LivresAuteurRepository;
import bibliotheque.repositories.LivresCategoryRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@AllArgsConstructor
public class ExemplaireService {
    private final ExemplaireRepository exemplaireRepository;
    private final LivresAuteurRepository livresAuteurRepository;
    private final LivresCategoryRepository livresCategoryRepository;

    @Transactional(readOnly = true)
    public ExemplaireDTO findByIdLivre(Integer idLivre) {
        Exemplaire exemplaire = exemplaireRepository.findByIdLivreId(idLivre);
        if (exemplaire == null) {
            return null;
        }

        ExemplaireDTO dto = new ExemplaireDTO();
        dto.setId(exemplaire.getId());
        dto.setQuantite(exemplaire.getQuantite());

        // Infos du livre
        var livre = exemplaire.getIdLivre();
        dto.setLivreId(livre.getId());
        dto.setLivreTitre(livre.getTitre());
        dto.setIsbn(livre.getIsbn());
        dto.setAnneePublication(livre.getAnneePublication());
        dto.setResume(livre.getResume());

        if (livre.getIdEditeur() != null) {
            dto.setEditeurNom(livre.getIdEditeur().getNom());
        }
        dto.setAuteurs(livresAuteurRepository.findByIdLivreId(idLivre).stream()
            .map(la -> la.getIdAuteur().getNom() + " " + la.getIdAuteur().getPrenom())
            .toList());

        dto.setCategories(livresCategoryRepository.findByIdLivreId(idLivre).stream()
            .map(lc -> lc.getIdCategorie().getNom())
            .toList());

        return dto;
    }
}
