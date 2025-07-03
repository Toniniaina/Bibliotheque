package bibliotheque.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "statuts_reservation")
public class StatutsReservation {
    @Id
    @Column(name = "id_statut", nullable = false)
    private Integer id;

    @Column(name = "code_statut", nullable = false, length = 20)
    private String codeStatut;

}