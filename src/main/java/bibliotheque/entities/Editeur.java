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
@Table(name = "editeurs")
public class Editeur {
    @Id
    @Column(name = "id_editeur", nullable = false)
    private Integer id;

    @Column(name = "nom", nullable = false, length = 150)
    private String nom;

}