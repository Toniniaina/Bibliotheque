package bibliotheque.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
@Entity
@Table(name = "livres")
public class Livre {
    @Id
    @Column(name = "id_livre", nullable = false)
    private Integer id;

    @Column(name = "titre", nullable = false)
    private String titre;

    @Column(name = "isbn", length = 20)
    private String isbn;

    @Column(name = "annee_publication")
    private Integer anneePublication;

    @Column(name = "resume", length = Integer.MAX_VALUE)
    private String resume;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_editeur")
    private Editeur idEditeur;

}