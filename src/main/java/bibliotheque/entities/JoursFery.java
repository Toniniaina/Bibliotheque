package bibliotheque.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "jours_feries")
public class JoursFery {
    @Id
    @Column(name = "date_ferie", nullable = false)
    private LocalDate id;

    @Column(name = "description")
    private String description;

}