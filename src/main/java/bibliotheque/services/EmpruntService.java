package bibliotheque.services;

import bibliotheque.entities.Emprunt;
import bibliotheque.entities.MvtEmprunt;
import bibliotheque.models.EmpruntDTO;
import bibliotheque.repositories.EmpruntRepository;
import bibliotheque.repositories.MvtEmpruntRepository;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@AllArgsConstructor
public class EmpruntService {
    private final MvtEmpruntRepository mvtEmpruntRepository;

    @Autowired
    private EmpruntRepository empruntRepository;

    public List<MvtEmprunt> getAllEmprunts() {
        return mvtEmpruntRepository.findAll();
    }

    public List<EmpruntDTO> getAllEmpruntDTOs() {
        return getAllEmprunts().stream().map(e -> {
            EmpruntDTO dto = new EmpruntDTO();
            dto.setId(e.getIdEmprunt().getId());
            if (e.getIdEmprunt() != null && e.getIdEmprunt().getIdAdherent() != null) {
                dto.setAdherentId(e.getIdEmprunt().getIdAdherent().getId());
                dto.setAdherentNom(e.getIdEmprunt().getIdAdherent().getNom());
                dto.setAdherentPrenom(e.getIdEmprunt().getIdAdherent().getPrenom());
            }
            return dto;
        }).collect(Collectors.toList());
    }

    public List<EmpruntDTO> getRetardEmpruntDTOs() {
        Set<Integer> dejaAjoutes = new HashSet<>();
        return mvtEmpruntRepository.findAll().stream()
                .filter(mvt -> {
                    Emprunt emp = mvt.getIdEmprunt();
                    if (emp == null || emp.getId() == null) {
                        return false;
                    }
                    List<MvtEmprunt> mouvements = mvtEmpruntRepository.findByIdEmpruntOrderByDateMouvementDesc(emp);
                    if (mouvements.isEmpty()) {
                        return false;
                    }
                    MvtEmprunt dernier = mouvements.get(0);
                    int statut = dernier.getIdStatutNouveau().getId();
                    if (statut != 2 && statut != 4) {
                        return false;
                    }
                    LocalDate dateRetourReelle = dernier.getDateMouvement().atZone(ZoneId.systemDefault()).toLocalDate();
                    Instant dateRetourPrevueInstant = emp.getDateRetourPrevue();
                    if (dateRetourPrevueInstant == null) {
                        return false;
                    }
                    LocalDate dateRetourPrevue = dateRetourPrevueInstant.atZone(ZoneId.systemDefault()).toLocalDate();
                    boolean enRetard = dateRetourReelle.isAfter(dateRetourPrevue);
                    if (enRetard && !dejaAjoutes.contains(emp.getId())) {
                        dejaAjoutes.add(emp.getId());
                        return true;
                    } else {
                        return false;
                    }
                })
                .map(mvt -> {
                    Emprunt emp = mvt.getIdEmprunt();
                    EmpruntDTO dto = new EmpruntDTO();
                    dto.setId(emp.getId());
                    if (emp.getIdAdherent() != null) {
                        dto.setAdherentId(emp.getIdAdherent().getId());
                        dto.setAdherentNom(emp.getIdAdherent().getNom());
                        dto.setAdherentPrenom(emp.getIdAdherent().getPrenom());
                    }
                    dto.setExemplaires(List.of(emp.getIdExemplaire()));
                    return dto;
                })
                .collect(Collectors.toList());
    }
}
