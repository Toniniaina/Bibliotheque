package bibliotheque.controllers;

import bibliotheque.services.LivreService;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@AllArgsConstructor
@RequestMapping("/livre")
public class LivreController {
    private final LivreService livreService;
    @GetMapping("/list")
    public ModelAndView list(){
        ModelAndView mv= new ModelAndView("bibliothecaire/home");
        mv.addObject("livres",livreService.getAll());
        mv.addObject("pageName","../livre/list");
        return mv;
    }
}
