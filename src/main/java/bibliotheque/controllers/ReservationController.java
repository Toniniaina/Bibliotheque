package bibliotheque.controllers;

import bibliotheque.entities.Adherent;
import bibliotheque.entities.Livre;
import bibliotheque.entities.Reservation;
import bibliotheque.entities.StatutsReservation;
import bibliotheque.repositories.*;
import bibliotheque.services.ResrevationService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.security.Principal;
import java.time.Instant;
import java.time.LocalDate;

@Controller
@AllArgsConstructor
@RequestMapping("/resa")
public class ReservationController {
    private final ResrevationService resrevationService;
    private final LivreRepository livreRepository;
    private final AdherentRepository adherentRepository;
    private final ReservationRepository reservationRepository;
    private final StatutsReservationRepository statutsReservationRepository;
    private final ExemplaireRepository exemplaireRepository;

    @GetMapping("/create")
    public ModelAndView showResaForm(@RequestParam(value = "adherentId") Integer adherentId) {
        ModelAndView mv = new ModelAndView("adherent/home");
        mv.addObject("pageName", "../resa/create");
        // Charger les exemplaires avec titre du livre pour la vue (DTO)
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
        mv.addObject("adherentId", adherentId);
        return mv;
    }

    @PostMapping("/save")
    public ModelAndView saveResa(
            @RequestParam("idExemplaire") Integer idExemplaire,
            @RequestParam("adherentId") Integer adherentId,
            @RequestParam("dateExpiration") String dateExpirationStr
    ) {
        ModelAndView mv = new ModelAndView("adherent/home");
        mv.addObject("pageName", "../resa/create");
        // Toujours fournir la liste de DTOs pour éviter le lazy loading en JSP
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
        mv.addObject("adherentId", adherentId);

        try {
            resrevationService.createReservation(idExemplaire, adherentId, java.time.LocalDate.parse(dateExpirationStr));
            mv.addObject("success", "Réservation déposée avec succès !");
        } catch (Exception e) {
            mv.addObject("error", e.getMessage());
        }
        return mv;
    }
}
