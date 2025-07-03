package bibliotheque.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;

@Getter
@Setter
@Entity
@Table(name = "emprunts")
public class Emprunt {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_emprunt", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_exemplaire", nullable = false)
    private Exemplaire idExemplaire;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_adherent", nullable = false)
    private Adherent idAdherent;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_type_emprunt", nullable = false)
    private TypeEmprunt idTypeEmprunt;

    @Column(name = "date_emprunt", nullable = false)
    private Instant dateEmprunt;

    @Column(name = "date_retour_prevue", nullable = false)
    private Instant dateRetourPrevue;

}