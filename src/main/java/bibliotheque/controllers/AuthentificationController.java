package bibliotheque.controllers;

import bibliotheque.models.UtilisateurDto;
import bibliotheque.services.ProfilAdherentService;
import bibliotheque.services.UtilisateurService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequiredArgsConstructor
public class AuthentificationController {
    private final UtilisateurService utilisateurService;
    private final ProfilAdherentService profilAdherentService;

    @GetMapping("/signup")
    public ModelAndView signupForm() {
        ModelAndView mv = new ModelAndView("auth/signup");
        mv.addObject("utilisateurDto", new UtilisateurDto());
        mv.addObject("profils", profilAdherentService.getAllProfils());
        return mv;
    }

    @PostMapping("/signup")
    public ModelAndView signupSubmit(@ModelAttribute UtilisateurDto utilisateurDto, @RequestParam("type") String type) {
        boolean isAdherent = "adherent".equalsIgnoreCase(type);
        boolean success = utilisateurService.signup(utilisateurDto, isAdherent);
        ModelAndView mv = new ModelAndView("auth/signup");
        if (success) {
            mv.addObject("message", "Inscription réussie, veuillez vous connecter.");
        } else {
            mv.addObject("error", "Email déjà utilisé.");
        }
        return mv;
    }

    @GetMapping("/login")
    public ModelAndView loginForm() {
        ModelAndView mv = new ModelAndView("auth/login");
        mv.addObject("utilisateurDto", new UtilisateurDto());
        return mv;
    }

    @PostMapping("/login")
    public ModelAndView loginSubmit(@ModelAttribute UtilisateurDto utilisateurDto, HttpSession session) {
        Object user = utilisateurService.login(utilisateurDto);
        ModelAndView mv;
        if (user == null) {
            mv = new ModelAndView("auth/login");
            mv.addObject("error", "Identifiants invalides.");
        } else if (user instanceof bibliotheque.entities.Adherent) {
            session.setAttribute("user", user);
            mv = new ModelAndView("adherent/home");
            mv.addObject("user", user);
            mv.addObject("role", "adherent");
            mv.addObject("pageName", "Dashboard");
        } else {
            session.setAttribute("user", user);
            mv = new ModelAndView("bibliothecaire/home");
            mv.addObject("user", user);
            mv.addObject("role", "bibliothecaire");
            mv.addObject("pageName", "Dashboard");
        }
        return mv;
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @PostMapping("/logout")
    public String logoutPost(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
