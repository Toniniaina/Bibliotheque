package bibliotheque.controllers;

import bibliotheque.entities.Adherent;
import bibliotheque.entities.Livre;
import bibliotheque.entities.Reservation;
import bibliotheque.entities.StatutsReservation;
import bibliotheque.entities.MvtReservation;
import bibliotheque.models.ExemplaireDTO;
import bibliotheque.repositories.MvtReservationRepository;
import bibliotheque.repositories.*;
import bibliotheque.services.ResrevationService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
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
    private final MvtReservationRepository mvtReservationRepository;
    private final ExemplaireRepository exemplaireRepository;
    private final EmpruntRepository empruntRepository;

    @GetMapping("/create")
    public ModelAndView showResaForm(@RequestParam(value = "adherentId", required = false) Integer adherentId, HttpSession session) {
        // Si pas d'adherentId dans l'URL, on tente de le récupérer depuis la session utilisateur
        if (adherentId == null) {
            Object user = session.getAttribute("user");
            if (user instanceof bibliotheque.entities.Adherent) {
                adherentId = ((bibliotheque.entities.Adherent) user).getId();
            }
        }
        if (adherentId == null) {
            // Redirige vers login si aucun adhérent trouvé
            return new ModelAndView("redirect:/login");
        }
        ModelAndView mv = new ModelAndView("adherent/home");
        mv.addObject("pageName", "../resa/create");
        mv.addObject("exemplaires", exemplaireRepository.findAll().stream().map(ex -> {
            ExemplaireDTO dto = new ExemplaireDTO();
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

    @GetMapping("/a_valider")
    public ModelAndView listReservationsAValider() {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../resa/valider");
        // Récupérer les réservations dont le dernier mouvement a le statut "à valider" (id=1)
        var reservationsAValider = reservationRepository.findAll().stream()
            .filter(resa -> {
                var mvt = mvtReservationRepository.findTopByIdReservationOrderByDateMouvementDesc(resa);
                return mvt != null && mvt.getIdStatutNouveau() != null && mvt.getIdStatutNouveau().getId() == 1;
            })
            .toList();
        mv.addObject("reservations", reservationsAValider);
        return mv;
    }

    @PostMapping("/valider")
    public ModelAndView validerReservation(@RequestParam("idReservation") Integer idReservation) {
        ModelAndView mv = new ModelAndView("bibliothecaire/home");
        mv.addObject("pageName", "../resa/valider");

        try {
            Reservation resa = reservationRepository.findById(idReservation)
                .orElseThrow(() -> new IllegalArgumentException("Réservation introuvable"));
            StatutsReservation statutValide = statutsReservationRepository.findById(2)
                .orElseThrow(() -> new IllegalArgumentException("Statut validé introuvable"));

            Livre livre = resa.getIdLivre();
            LocalDate dateResa = resa.getDateExpiration();

            // Pour chaque exemplaire du livre, calcule la quantité restante à la date de réservation
            var exemplaires = exemplaireRepository.findAll().stream()
                .filter(ex -> ex.getIdLivre().getId().equals(livre.getId()))
                .toList();

            boolean exemplaireDispo = exemplaires.stream().anyMatch(ex -> {
                int quantiteTotale = ex.getQuantite() != null ? ex.getQuantite() : 0;
                // Compte les emprunts non rendus à la date de réservation
                long empruntsOccupants = empruntRepository.findAll().stream()
                    .filter(emp -> emp.getIdExemplaire().getId().equals(ex.getId()))
                    .filter(emp -> {
                        // Si la date de retour prévue est après la date de réservation, l'exemplaire est occupé
                        return emp.getDateRetourPrevue() != null &&
                               emp.getDateRetourPrevue().atZone(java.time.ZoneId.systemDefault()).toLocalDate().isAfter(dateResa.minusDays(1));
                    })
                    .count();
                int quantiteRestante = quantiteTotale;
                return quantiteRestante > 0;
            });

            if (!exemplaireDispo) {
                throw new IllegalArgumentException("Aucun exemplaire n'est disponible à la date de réservation demandée.");
            }

            // Si tout est OK, on valide la réservation
            MvtReservation mvt = new MvtReservation();
            mvt.setIdReservation(resa);
            mvt.setIdStatutNouveau(statutValide);
            mvt.setDateMouvement(java.time.Instant.now());
            mvtReservationRepository.save(mvt);

            mv.addObject("success", "Réservation validée avec succès !");
        } catch (Exception e) {
            mv.addObject("error", e.getMessage());
        }

        // Recharge la liste des réservations à valider
        var reservationsAValider = reservationRepository.findAll().stream()
            .filter(resa -> {
                var mvt = mvtReservationRepository.findTopByIdReservationOrderByDateMouvementDesc(resa);
                return mvt != null && mvt.getIdStatutNouveau() != null && mvt.getIdStatutNouveau().getId() == 1;
            })
            .toList();
        mv.addObject("reservations", reservationsAValider);

        return mv;
    }

    @PostMapping("/annuler")
    public String annulerReservation(@RequestParam("idReservation") Integer idReservation) {
        Reservation resa = reservationRepository.findById(idReservation)
            .orElseThrow(() -> new IllegalArgumentException("Réservation introuvable"));
        StatutsReservation statutAnnule = statutsReservationRepository.findById(3)
            .orElseThrow(() -> new IllegalArgumentException("Statut annulé introuvable"));

        MvtReservation mvt = new MvtReservation();
        mvt.setIdReservation(resa);
        mvt.setIdStatutNouveau(statutAnnule);
        mvt.setDateMouvement(java.time.Instant.now());
        mvtReservationRepository.save(mvt);

        return "redirect:/resa/a_valider";
    }

}
