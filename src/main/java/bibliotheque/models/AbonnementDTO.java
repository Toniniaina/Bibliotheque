package bibliotheque.models;

import bibliotheque.entities.Adherent;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Data
public class AbonnementDTO {
    private Long id;
    private Integer adherent;
    private LocalDate dateDebut;
    private LocalDate dateFin;
}
