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
        // Afficher uniquement les emprunts dont le dernier mouvement est "emprunté" (id=1)
        var allEmpruntDTOs = empruntService.getAllEmpruntDTOs();
        var eligibleEmprunts = allEmpruntDTOs.stream().filter(dto -> {
            Emprunt emp = empruntRepository.findById(dto.getId()).orElse(null);
            if (emp == null) return false;
            var mvtList = mvtEmpruntRepository.findByIdEmpruntOrderByDateMouvementDesc(emp);
            if (mvtList == null || mvtList.isEmpty()) return false;
            // On prend le mouvement le plus récent (le premier de la liste)
            var dernierMvt = mvtList.get(0);
            return dernierMvt.getIdStatutNouveau() != null && dernierMvt.getIdStatutNouveau().getId() == 1;
        }).toList();
        mv.addObject("emprunts", eligibleEmprunts);
        return mv;
    }

    @PostMapping("/save")
    public String saveRetour(
            @RequestParam("empruntId") Integer empruntId,
            @RequestParam("dateMouvement") String dateMouvementStr
    ) {
        // Traitement du retour (identique à avant)
        try {
            Emprunt emprunt = empruntRepository.findById(empruntId)
                    .orElseThrow(() -> new IllegalArgumentException("Emprunt introuvable"));
            var mvtList = mvtEmpruntRepository.findByIdEmpruntOrderByDateMouvementDesc(emprunt);
            if (mvtList == null || mvtList.isEmpty() || mvtList.get(0).getIdStatutNouveau() == null || mvtList.get(0).getIdStatutNouveau().getId() != 1) {
                throw new IllegalArgumentException("Cet emprunt ne peut pas être rendu (déjà rendu ou non éligible).");
            }
            Instant dateMouvement = parseDateTime(dateMouvementStr);

            MvtEmprunt mvt = new MvtEmprunt();
            mvt.setIdEmprunt(emprunt);
            StatutsEmprunt statutRetourne = new StatutsEmprunt();
            statutRetourne.setId(2); // 2 = retourné
            mvt.setIdStatutNouveau(statutRetourne);
            mvt.setDateMouvement(dateMouvement);
            mvtEmpruntRepository.save(mvt);

            // Ajoute un message flash si besoin (optionnel)
            // redirectAttributes.addFlashAttribute("success", "Retour enregistré !");
        } catch (Exception e) {
            // redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        // Redirige toujours vers la page de création (GET) pour éviter l'affichage de tous les emprunts
        return "redirect:/rendrepret/create";
    }

    private Instant parseDateTime(String dateTimeStr) {
        if (dateTimeStr == null || dateTimeStr.isEmpty()) {
            throw new IllegalArgumentException("Date cannot be empty");
        }
        LocalDateTime localDateTime = LocalDateTime.parse(dateTimeStr);
        return localDateTime.atZone(ZoneId.systemDefault()).toInstant();
    }
}