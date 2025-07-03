package bibliotheque.models;

import lombok.Data;
import java.time.Instant;

@Data
public class MvtEmpruntDTO {
    private Integer id;
    private Integer empruntId;
    private Integer statutId;
    private Instant dateMouvement;
}
