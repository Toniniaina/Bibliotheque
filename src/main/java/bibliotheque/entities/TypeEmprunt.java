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
@Table(name = "type_emprunts")
public class TypeEmprunt {
    @Id
    @Column(name = "id_type_emprunt", nullable = false)
    private Integer id;

    @Column(name = "nom_type", length = 50)
    private String nomType;

}