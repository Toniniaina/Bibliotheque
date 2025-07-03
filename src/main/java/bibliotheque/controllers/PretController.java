package bibliotheque.controllers;

import bibliotheque.models.EmpruntDTO;
import bibliotheque.services.AdherentService;
import bibliotheque.repositories.ExemplaireRepository;
import bibliotheque.services.PretService;
import bibliotheque.repositories.TypeEmpruntRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

@Controller
@AllArgsConstructor
@RequestMapping("/pret")
public class PretController {

    private final PretService pretService;
    private final AdherentService adherentService;
    private final ExemplaireRepository exemplaireRepository;
    private final TypeEmpruntRepository typeEmpruntRepository; // Ajout

    @GetMapping("/create")
    public ModelAndView showPretForm() {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../pret/create");
        mv.addObject("adherents", adherentService.getAllAdherents());
        mv.addObject("typesEmprunt", typeEmpruntRepository.findAll()); // Ajout
        mv.addObject("exemplaires", exemplaireRepository.findAll().stream().map(ex -> {
            bibliotheque.models.ExemplaireDTO dto = new bibliotheque.models.ExemplaireDTO();
            dto.setId(ex.getId());
            dto.setQuantite(ex.getQuantite());
            if (ex.getIdLivre() != null) {
                dto.setLivreId(ex.getIdLivre().getId());
                dto.setLivreTitre(ex.getIdLivre().getTitre());
            }
            return dto;
        }).toList());
        return mv;
    }

    @PostMapping("/save")
    public ModelAndView savePret(
            @ModelAttribute EmpruntDTO dto,
            @RequestParam("datePret") String datePretStr,
            @RequestParam("dateRetourPrevue") String dateRetourPrevueStr,
            @RequestParam("idTypeEmprunt") Integer idTypeEmprunt // Ajout
    ) {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../pret/create");
        mv.addObject("adherents", adherentService.getAllAdherents());
        mv.addObject("typesEmprunt", typeEmpruntRepository.findAll()); // Ajout
        mv.addObject("exemplaires", exemplaireRepository.findAll().stream().map(ex -> {
            bibliotheque.models.ExemplaireDTO dtoEx = new bibliotheque.models.ExemplaireDTO();
            dtoEx.setId(ex.getId());
            dtoEx.setQuantite(ex.getQuantite());
            if (ex.getIdLivre() != null) {
                dtoEx.setLivreId(ex.getIdLivre().getId());
                dtoEx.setLivreTitre(ex.getIdLivre().getTitre());
            }
            return dtoEx;
        }).toList());

        try {
            Instant datePret = parseDateTime(datePretStr);
            Instant dateRetourPrevue = parseDateTime(dateRetourPrevueStr);

            dto.setIdTypeEmprunt(typeEmpruntRepository.findById(idTypeEmprunt).orElse(null));
            if (dto.getIdTypeEmprunt() == null) {
                throw new IllegalArgumentException("Type d'emprunt obligatoire.");
            }

            pretService.creerPret(dto, datePret, dateRetourPrevue);
            mv.addObject("success", "Prêt enregistré avec succès !");

        } catch (DateTimeParseException e) {
            mv.addObject("error", "Format de date invalide. Veuillez utiliser le format: YYYY-MM-DD HH:MM");
        } catch (Exception e) {
            mv.addObject("error", e.getMessage());
        }

        return mv;
    }

    private Instant parseDateTime(String dateTimeStr) {
        if (dateTimeStr == null || dateTimeStr.isEmpty()) {
            throw new IllegalArgumentException("Date cannot be empty");
        }

        try {
            // Handle datetime-local format (yyyy-MM-ddTHH:mm)
            LocalDateTime localDateTime = LocalDateTime.parse(dateTimeStr);
            return localDateTime.atZone(ZoneId.systemDefault()).toInstant();
        } catch (DateTimeParseException e) {
            throw new DateTimeParseException("Invalid datetime format: " + dateTimeStr, dateTimeStr, 0);
        }
    }
}