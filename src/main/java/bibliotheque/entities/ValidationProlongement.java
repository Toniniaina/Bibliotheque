package bibliotheque.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "validation_prolongement")
public class ValidationProlongement {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_validation", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_prolongement", nullable = false)
    private Prolongement idProlongement;

    @Column(name = "date_validation", nullable = false)
    private LocalDate dateValidation;

    @Column(name = "valide", nullable = false)
    private Boolean valide = false;

}