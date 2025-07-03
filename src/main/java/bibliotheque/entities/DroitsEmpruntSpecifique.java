package bibliotheque.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@Setter
@Entity
@Table(name = "droits_emprunt_specifiques")
public class DroitsEmpruntSpecifique {
    @Id
    @Column(name = "id_droit", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre idLivre;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_profil", nullable = false)
    private ProfilsAdherent idProfil;

    @Column(name = "age")
    private Integer age;

    @Column(name = "emprunt_surplace_autorise", nullable = false)
    private Boolean empruntSurplaceAutorise = false;

    @Column(name = "emprunt_domicile_autorise", nullable = false)
    private Boolean empruntDomicileAutorise = false;

}