package bibliotheque.models;

import bibliotheque.entities.Adherent;
import bibliotheque.entities.Bibliothecaire;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class UtilisateurDto {
    private Integer idUtilisateur;
    private Bibliothecaire idBibliothecaire;
    private Adherent idAdherent;
    private String email;
    private String nom;
    private String prenom;
    private String mdp;
    private LocalDate datecreation;
    private LocalDate datenaissance;
    private String telephone;
}
