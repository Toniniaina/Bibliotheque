package bibliotheque.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "profils_adherent")
public class ProfilsAdherent {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_profil", nullable = false)
    private Integer id;

    @Column(name = "nom_profil", nullable = false, length = 100)
    private String nomProfil;

    @Column(name = "quota_emprunts_simultanes", nullable = false)
    private Integer quotaEmpruntsSimultanes;

}