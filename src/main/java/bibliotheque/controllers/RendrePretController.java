package bibliotheque.controllers;

import bibliotheque.entities.Emprunt;
import bibliotheque.entities.MvtEmprunt;
import bibliotheque.entities.StatutsEmprunt;
import bibliotheque.repositories.EmpruntRepository;
import bibliotheque.repositories.MvtEmpruntRepository;
import bibliotheque.services.EmpruntService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeParseException;

@Controller
@AllArgsConstructor
@RequestMapping("/rendrepret")
public class RendrePretController {
    private final EmpruntRepository empruntRepository;
    private final MvtEmpruntRepository mvtEmpruntRepository;
    private final EmpruntService empruntService;

    @GetMapping("/create")
    public ModelAndView showForm() {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../rendrepret/create");
        // Afficher uniquement les emprunts qui n'ont pas encore été rendus (dernier mouvement = 1)
        var allEmpruntDTOs = empruntService.getAllEmpruntDTOs();
        var eligibleEmprunts = allEmpruntDTOs.stream().filter(dto -> {
            Emprunt emp = empruntRepository.findById(dto.getId()).orElse(null);
            if (emp == null) return false;
            var mvtList = mvtEmpruntRepository.findByIdEmpruntOrderByDateMouvementDesc(emp);
            // Dernier mouvement doit être statut 1 (emprunté)
            return mvtList != null && !mvtList.isEmpty() && mvtList.get(0).getIdStatutNouveau() != null && mvtList.get(0).getIdStatutNouveau().getId() == 1;
        }).toList();
        mv.addObject("emprunts", eligibleEmprunts);
        return mv;
    }

    @PostMapping("/save")
    public ModelAndView saveRetour(
            @RequestParam("empruntId") Integer empruntId,
            @RequestParam("dateMouvement") String dateMouvementStr
    ) {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../rendrepret/create");
        mv.addObject("emprunts", empruntService.getAllEmpruntDTOs());

        try {
            Emprunt emprunt = empruntRepository.findById(empruntId)
                    .orElseThrow(() -> new IllegalArgumentException("Emprunt introuvable"));
            Instant dateMouvement = parseDateTime(dateMouvementStr);

            MvtEmprunt mvt = new MvtEmprunt();
            mvt.setIdEmprunt(emprunt);
            StatutsEmprunt statutRetourne = new StatutsEmprunt();
            statutRetourne.setId(2); // 2 = retourné
            mvt.setIdStatutNouveau(statutRetourne);
            mvt.setDateMouvement(dateMouvement);
            mvtEmpruntRepository.save(mvt);

            mv.addObject("success", "Retour enregistré !");
        } catch (DateTimeParseException e) {
            mv.addObject("error", "Format de date invalide.");
        } catch (Exception e) {
            mv.addObject("error", e.getMessage());
        }
        return mv;
    }

    private Instant parseDateTime(String dateTimeStr) {
        if (dateTimeStr == null || dateTimeStr.isEmpty()) {
            throw new IllegalArgumentException("Date cannot be empty");
        }
        LocalDateTime localDateTime = LocalDateTime.parse(dateTimeStr);
        return localDateTime.atZone(ZoneId.systemDefault()).toInstant();
    }
}
