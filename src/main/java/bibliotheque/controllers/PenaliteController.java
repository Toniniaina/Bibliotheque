package bibliotheque.controllers;

import bibliotheque.entities.Emprunt;
import bibliotheque.entities.Adherent;
import bibliotheque.models.PenaliteDTO;
import bibliotheque.repositories.EmpruntRepository;
import bibliotheque.services.AdherentService;
import bibliotheque.services.EmpruntService;
import bibliotheque.services.PenaliteService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@AllArgsConstructor
@RequestMapping("/penalite")
public class PenaliteController {
    private final PenaliteService penaliteService;
    private final EmpruntService empruntService;
    private final AdherentService adherentService;
    private final EmpruntRepository empruntRepository;

    @GetMapping("/create")
    public ModelAndView showForm() {
        return buildPenaliteForm(new PenaliteDTO(), null);
    }

    @PostMapping("/save")
    public ModelAndView save(@ModelAttribute PenaliteDTO dto) {
        String message = null;
        String error = null;

        try {
            if (dto.getEmprunt() != null && dto.getEmprunt().getId() != null) {
                Emprunt empruntComplet = empruntRepository.findById(dto.getEmprunt().getId())
                        .orElseThrow(() -> new IllegalArgumentException("Emprunt non trouvé"));
                dto.setEmprunt(empruntComplet);
            }

            if (dto.getAdherent() != null && dto.getAdherent().getId() != null) {
                Adherent adherentComplet = adherentService.getAdherentById(dto.getAdherent().getId());
                dto.setAdherent(adherentComplet);
            }

            penaliteService.createPenalite(dto);
            message = "Pénalité enregistrée avec succès !";
        } catch (Exception e) {
            error = e.getMessage();
        }

        return buildPenaliteForm(dto, message != null ? message : error);
    }

    private ModelAndView buildPenaliteForm(PenaliteDTO dto, String feedbackMessage) {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../penalite/create");
        mv.addObject("emprunts", empruntService.getRetardEmpruntDTOs());
        mv.addObject("adherents", adherentService.getAllAdherents());
        List<Integer> penalisedEmpruntIds = penaliteService.getAllPenalites().stream()
                .map(p -> p.getIdEmprunt().getId())
                .distinct()
                .collect(Collectors.toList());
        mv.addObject("penalisedEmpruntIds", penalisedEmpruntIds);
        mv.addObject("penalisedEmpruntIdsAsString", penalisedEmpruntIds.toString());

        if (feedbackMessage != null) {
            if (feedbackMessage.startsWith("Pénalité enregistrée")) {
                mv.addObject("success", feedbackMessage);
            } else {
                mv.addObject("error", feedbackMessage);
            }
        }

        return mv;
    }
}
