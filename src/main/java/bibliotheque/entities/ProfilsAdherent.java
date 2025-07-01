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
@Table(name = "profils_adherent")
public class ProfilsAdherent {
    @Id
    @Column(name = "id_profil", nullable = false)
    private Integer id;

    @Column(name = "nom_profil", nullable = false, length = 100)
    private String nomProfil;

    @Column(name = "quota_emprunts_simultanes", nullable = false)
    private Integer quotaEmpruntsSimultanes;

    @Column(name = "duree_pret_domicile_jours", nullable = false)
    private Integer dureePretDomicileJours;

    @Column(name = "duree_pret_sur_place_heures", nullable = false)
    private Integer dureePretSurPlaceHeures;

    @Column(name = "peut_prolonger_pret", nullable = false)
    private Boolean peutProlongerPret = false;

    @Column(name = "jours_penalite_par_retard", nullable = false)
    private Integer joursPenaliteParRetard;

}