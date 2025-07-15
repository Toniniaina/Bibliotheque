package bibliotheque.dto;

import lombok.Getter;
import lombok.Setter;
import java.util.List;

@Getter
@Setter
public class ExemplaireDTO {
    private Integer id;
    private Integer quantite;
    private Integer livreId;
    private String livreTitre;
    private String isbn;
    private Integer anneePublication;
    private String resume;
    private String editeurNom;
    private List<String> auteurs;
    private List<String> categories;
}
