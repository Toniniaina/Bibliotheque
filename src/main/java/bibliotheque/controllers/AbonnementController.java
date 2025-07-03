package bibliotheque.controllers;

import bibliotheque.models.AbonnementDTO;
import bibliotheque.services.AbonnementService;
import bibliotheque.services.AdherentService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@AllArgsConstructor
@RequestMapping("/abonnement")
public class AbonnementController {
    private final AbonnementService abonnementService;
    private final AdherentService adherentService;

    @GetMapping("/create")
    public ModelAndView formAbonnement() {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("adhe", adherentService.getAllAdherents());
        mv.addObject("pageName", "../abonnement/create");
        return mv;
    }

    @PostMapping("/save")
    public ModelAndView saveAbonnement(@ModelAttribute AbonnementDTO dto) {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("adhe", adherentService.getAllAdherents());
        mv.addObject("pageName", "../abonnement/create");

        try {
            abonnementService.createAbonnement(dto);
            mv.addObject("success", "Abonnement créé avec succès !");
        } catch (IllegalArgumentException e) {
            mv.addObject("error", e.getMessage());
        } catch (Exception e) {
            mv.addObject("error", "Une erreur est survenue.");
        }

        return mv;
    }

}

