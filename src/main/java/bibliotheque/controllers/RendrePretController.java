package bibliotheque.controllers;

import bibliotheque.entities.Emprunt;
import bibliotheque.entities.MvtEmprunt;
import bibliotheque.entities.StatutsEmprunt;
import bibliotheque.repositories.EmpruntRepository;
import bibliotheque.repositories.MvtEmpruntRepository;
import bibliotheque.services.EmpruntService;
import bibliotheque.services.PenaliteService;
import bibliotheque.models.PenaliteDTO;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeParseException;
import bibliotheque.repositories.JoursFeryRepository;
import java.time.LocalDate;

@Controller
@AllArgsConstructor
@RequestMapping("/rendrepret")
public class RendrePretController {
    private final EmpruntRepository empruntRepository;
    private final MvtEmpruntRepository mvtEmpruntRepository;
    private final EmpruntService empruntService;
    private final PenaliteService penaliteService;
    private final JoursFeryRepository joursFeryRepository;

    @GetMapping("/create")
    public ModelAndView showForm() {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../rendrepret/create");
        var allEmpruntDTOs = empruntService.getAllEmpruntDTOs();
        var eligibleEmprunts = allEmpruntDTOs.stream().filter(dto -> {
            Emprunt emp = empruntRepository.findById(dto.getId()).orElse(null);
            if (emp == null) return false;
            var mvtList = mvtEmpruntRepository.findByIdEmpruntOrderByDateMouvementDesc(emp);
            if (mvtList == null || mvtList.isEmpty()) return false;
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
            statutRetourne.setId(2);
            mvt.setIdStatutNouveau(statutRetourne);
            mvt.setDateMouvement(dateMouvement);
            mvtEmpruntRepository.save(mvt);

            // Gestion jours fériés : reporter la date limite si besoin
            LocalDate dateLimite = null;
            if (emprunt.getDateRetourPrevue() != null) {
                dateLimite = emprunt.getDateRetourPrevue().atZone(java.time.ZoneId.systemDefault()).toLocalDate();
                // Si la date limite tombe sur un jour férié, on la décale au prochain jour non férié
                while (joursFeryRepository.existsById(dateLimite)) {
                    dateLimite = dateLimite.plusDays(1);
                }
            }
            // Pénalisation automatique si retard (après report jours fériés)
            if (dateLimite != null && dateMouvement.atZone(java.time.ZoneId.systemDefault()).toLocalDate().isAfter(dateLimite)) {
                PenaliteDTO penaliteDTO = new PenaliteDTO();
                penaliteDTO.setEmprunt(emprunt);
                penaliteDTO.setAdherent(emprunt.getIdAdherent());
                penaliteDTO.setRaison("Retour en retard");
                penaliteService.createPenalite(penaliteDTO);
            }

        } catch (Exception e) {
            // redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
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