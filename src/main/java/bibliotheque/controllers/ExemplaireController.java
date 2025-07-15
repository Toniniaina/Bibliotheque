package bibliotheque.controllers;

import bibliotheque.dto.ExemplaireDTO;
import bibliotheque.services.ExemplaireService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/api/exemplaire")
public class ExemplaireController {
    private final ExemplaireService exemplaireService;

    @GetMapping("/livre/{idLivre}")
    public ExemplaireDTO getExemplaireByLivreId(@PathVariable Integer idLivre) {
        return exemplaireService.findByIdLivre(idLivre);
    }
}
