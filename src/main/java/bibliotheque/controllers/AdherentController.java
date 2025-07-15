package bibliotheque.controllers;

import bibliotheque.entities.Abonnement;
import bibliotheque.entities.Adherent;
import bibliotheque.entities.Penalite;
import bibliotheque.models.ExemplaireDTO;
import bibliotheque.services.AbonnementService;
import bibliotheque.services.AdherentService;
import bibliotheque.services.EmpruntService;
import bibliotheque.services.PenaliteService;
import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@AllArgsConstructor
@RequestMapping("/adherent")
public class AdherentController {
    private final AdherentService adherentService;
    private final AbonnementService abonnementService;
    private final PenaliteService penaliteService;
    private final EmpruntService empruntService;

    @GetMapping("/info/{id}")
    public Map<String, Object> getAdherentInfo(@PathVariable Integer id) {
        Map<String, Object> result = new HashMap<>();
        Adherent adherent = adherentService.getAdherentById(id);
        if (adherent == null) {
            result.put("error", "Adhérent introuvable");
            return result;
        }
        // Abonnement actif (le plus récent dont la date de fin >= aujourd'hui)
        List<Abonnement> abonnements = abonnementService.getAbonnementsByAdherentId(id);
        Abonnement abonnementActif = abonnements.stream()
            .filter(ab -> !ab.getDateFin().isBefore(LocalDate.now()))
            .max(Comparator.comparing(Abonnement::getDateFin))
            .orElse(null);
        if (abonnementActif != null) {
            result.put("dateDebutAbonnement", abonnementActif.getDateDebut());
            result.put("dateFinAbonnement", abonnementActif.getDateFin());
        } else {
            result.put("dateDebutAbonnement", null);
            result.put("dateFinAbonnement", null);
        }
        // Quota
        int quota = adherent.getIdProfil().getQuotaEmpruntsSimultanes();
        result.put("quota", quota);
        // Emprunts non retournés (pour le calcul du quota restant)
        int nbEmpruntsNonRendus = empruntService.getEmpruntsNonRendusByAdherentId(id).size();
        result.put("quotaRestant", quota - nbEmpruntsNonRendus);
        // Emprunts en cours (non retournés) pour affichage
        List<Map<String, Object>> empruntsEnCours = empruntService
            .getAllEmpruntDTOs().stream()
            .filter(e -> e.getAdherentId() != null && e.getAdherentId().equals(id))
            .collect(Collectors.toList())
            .stream()
            .map(e -> {
                Map<String, Object> ex = new HashMap<>();
                ex.put("livreId", e.getLivreId());
                ex.put("livreTitre", e.getLivreTitre());
                ex.put("exemplaires", e.getExemplaires());
                return ex;
            })
            .collect(Collectors.toList());
        result.put("exemplairesPretes", empruntsEnCours);
        // Pénalité
        List<Penalite> penalites = penaliteService.getAllPenalites().stream()
            .filter(p -> p.getIdAdherent() != null && p.getIdAdherent().getId().equals(id))
            .collect(Collectors.toList());
        Penalite penaliteEnCours = penalites.stream()
            .filter(p -> {
                LocalDate fin = p.getDateDebut().plusDays(p.getJour());
                return !fin.isBefore(LocalDate.now());
            })
            .max(Comparator.comparing(Penalite::getDateDebut))
            .orElse(null);
        if (penaliteEnCours != null) {
            result.put("penalise", true);
            result.put("dateDebutPenalite", penaliteEnCours.getDateDebut());
            result.put("dateFinPenalite", penaliteEnCours.getDateDebut().plusDays(penaliteEnCours.getJour()));
        } else {
            result.put("penalise", false);
            result.put("dateDebutPenalite", null);
            result.put("dateFinPenalite", null);
        }
        return result;
    }

    @GetMapping("/list")
    public ModelAndView listAdherentsPage() {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../adherent/list");
        mv.addObject("adherents", adherentService.getAllAdherents());
        return mv;
    }
}
