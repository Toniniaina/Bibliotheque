package bibliotheque.models;

import bibliotheque.entities.Exemplaire;
import bibliotheque.entities.TypeEmprunt;
import lombok.Data;

import java.util.List;

@Data
public class EmpruntDTO {
    private Integer id;
    private Integer adherentId;
    private String adherentNom;
    private String adherentPrenom;
    private List<ExemplaireDTO> exemplaires;
    private String livreTitre;
    private Integer livreId;
    private TypeEmprunt idTypeEmprunt;
    private String dateRetourPrevue; // Changed to String
}

