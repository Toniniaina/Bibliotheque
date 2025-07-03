package bibliotheque.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.time.Instant;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "reservations")
public class Reservation {
    @Id
    @Column(name = "id_reservation", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_livre", nullable = false)
    private Livre idLivre;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "id_adherent", nullable = false)
    private Adherent idAdherent;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "id_statut", nullable = false)
    private StatutsReservation idStatut;

    @Column(name = "date_demande", nullable = false)
    private Instant dateDemande;

    @Column(name = "date_expiration", nullable = false)
    private LocalDate dateExpiration;

}