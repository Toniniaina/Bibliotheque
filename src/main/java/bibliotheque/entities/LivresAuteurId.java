package bibliotheque.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.Hibernate;

import java.io.Serializable;
import java.util.Objects;

@Getter
@Setter
@Embeddable
public class LivresAuteurId implements Serializable {
    private static final long serialVersionUID = -2954419110434239365L;
    @Column(name = "id_livre", nullable = false)
    private Integer idLivre;

    @Column(name = "id_auteur", nullable = false)
    private Integer idAuteur;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        LivresAuteurId entity = (LivresAuteurId) o;
        return Objects.equals(this.idAuteur, entity.idAuteur) &&
                Objects.equals(this.idLivre, entity.idLivre);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idAuteur, idLivre);
    }

}