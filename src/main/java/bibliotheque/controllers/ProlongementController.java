package bibliotheque.controllers;

import bibliotheque.entities.Emprunt;
import bibliotheque.entities.Prolongement;
import bibliotheque.repositories.EmpruntRepository;
import bibliotheque.repositories.ProlongementRepository;
import bibliotheque.repositories.MvtEmpruntRepository;
import bibliotheque.services.ProlongementService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;

@Controller
@AllArgsConstructor
@RequestMapping("/prolongement")
public class ProlongementController {
    private final EmpruntRepository empruntRepository;
    private final ProlongementRepository prolongementRepository;
    private final MvtEmpruntRepository mvtEmpruntRepository;
    private final ProlongementService prolongementService;

    @GetMapping("/create")
    public ModelAndView showForm() {
        ModelAndView mv = new ModelAndView("adherent/home");
        mv.addObject("pageName", "../prolongement/create");
        // Filtrer les emprunts qui ne sont pas déjà retournés (statut 2)
        mv.addObject("emprunts", empruntRepository.findAll().stream().filter(e -> {
            var mvtList = mvtEmpruntRepository.findByIdEmpruntOrderByDateMouvementDesc(e);
            if (mvtList == null || mvtList.isEmpty()) return true;
            var dernierMvt = mvtList.get(0);
            return dernierMvt == null || (dernierMvt.getIdStatutNouveau() != null && dernierMvt.getIdStatutNouveau().getId() != 2);
        }).toList());
        return mv;
    }

    @PostMapping("/save")
    public ModelAndView saveProlongement(
            @RequestParam("empruntId") Integer empruntId,
            @RequestParam("dateFin") String dateFinStr
    ) {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../prolongement/create");
        mv.addObject("emprunts", empruntRepository.findAll());

        try {
            Emprunt emprunt = empruntRepository.findById(empruntId)
                    .orElseThrow(() -> new IllegalArgumentException("Emprunt introuvable"));
            LocalDate dateFin = LocalDate.parse(dateFinStr);

            Prolongement prolongement = new Prolongement();
            prolongement.setIdEmprunt(emprunt);
            prolongement.setDateFin(dateFin);
            prolongement.setDateProlongement(LocalDate.now());
            prolongementRepository.save(prolongement);

            mv.addObject("success", "Prolongement enregistré !");
        } catch (Exception e) {
            mv.addObject("error", e.getMessage());
        }
        return mv;
    }

    @GetMapping("/validation")
    public ModelAndView showValidationForm(@ModelAttribute("pageName") String pageName) {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../prolongement/validation");
        mv.addObject("prolongementsNonValides", prolongementService.getProlongementsNonValides());
        return mv;
    }

    @PostMapping("/valider")
    public ModelAndView validerProlongement(
            @RequestParam Integer idProlongement,
            @RequestParam Boolean valide,
            @ModelAttribute("pageName") String pageName) {

        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../prolongement/validation");

        try {
            prolongementService.validerProlongement(idProlongement, valide);
            mv.addObject("success", "Le prolongement a été " + (valide ? "accepté" : "refusé") + " avec succès.");
        } catch (Exception e) {
            mv.addObject("error", "Erreur lors de la validation : " + e.getMessage());
        }

        mv.addObject("prolongementsNonValides", prolongementService.getProlongementsNonValides());
        return mv;
    }
}
