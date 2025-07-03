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
public class LivresCategoryId implements Serializable {
    private static final long serialVersionUID = 4265677234400913585L;
    @Column(name = "id_livre", nullable = false)
    private Integer idLivre;

    @Column(name = "id_categorie", nullable = false)
    private Integer idCategorie;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || Hibernate.getClass(this) != Hibernate.getClass(o)) return false;
        LivresCategoryId entity = (LivresCategoryId) o;
        return Objects.equals(this.idLivre, entity.idLivre) &&
                Objects.equals(this.idCategorie, entity.idCategorie);
    }

    @Override
    public int hashCode() {
        return Objects.hash(idLivre, idCategorie);
    }

}