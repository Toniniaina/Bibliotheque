package bibliotheque.models;

import bibliotheque.entities.Emprunt;
import bibliotheque.entities.Adherent;
import lombok.Data;
import java.time.LocalDate;

@Data
public class PenaliteDTO {
    private Emprunt emprunt;
    private Adherent adherent;
    private LocalDate dateDebut;
    private Integer jour;
    private String raison;
}
