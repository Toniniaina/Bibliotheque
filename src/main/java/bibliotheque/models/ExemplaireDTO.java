package bibliotheque.models;

import lombok.Data;

@Data
public class ExemplaireDTO {
    private Integer id;
    private Integer quantite;
    private Integer livreId;
    private String livreTitre;
}
