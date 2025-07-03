package bibliotheque.models;

import bibliotheque.entities.Exemplaire;
import lombok.Data;

import java.util.List;

@Data
public class EmpruntDTO {
    private Integer id;
    private Integer adherentId;
    private String adherentNom;
    private String adherentPrenom;
    private List<Exemplaire> exemplaires;

}
