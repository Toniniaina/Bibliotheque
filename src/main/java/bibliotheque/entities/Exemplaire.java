package bibliotheque.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "exemplaires")
public class Exemplaire {
    @Id
    @Column(name = "id_exemplaire", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre idLivre;

    @Column(name = "quantite", nullable = false)
    private Integer quantite;

}