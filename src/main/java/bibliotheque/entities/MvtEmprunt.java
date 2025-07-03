package bibliotheque.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "mvt_emprunt")
public class MvtEmprunt {
    @Id
    @Column(name = "id_mvt_emprunt", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_emprunt", nullable = false)
    private Emprunt idEmprunt;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_statut_nouveau", nullable = false)
    private StatutsEmprunt idStatutNouveau;

    @Column(name = "date_mouvement", nullable = false)
    private Instant dateMouvement;

}