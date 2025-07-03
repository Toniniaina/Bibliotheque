package bibliotheque.services;

import bibliotheque.entities.Emprunt;
import bibliotheque.entities.Exemplaire;
import bibliotheque.entities.MvtEmprunt;
import bibliotheque.models.EmpruntDTO;
import bibliotheque.models.ExemplaireDTO;
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
            // Ajout exemplaire/livre
            if (e.getIdEmprunt() != null && e.getIdEmprunt().getIdExemplaire() != null) {
                Exemplaire ex = e.getIdEmprunt().getIdExemplaire();
                ExemplaireDTO exDto = new ExemplaireDTO();
                exDto.setId(ex.getId());
                exDto.setQuantite(ex.getQuantite());
                if (ex.getIdLivre() != null) {
                    exDto.setLivreId(ex.getIdLivre().getId());
                    exDto.setLivreTitre(ex.getIdLivre().getTitre());
                    dto.setLivreId(ex.getIdLivre().getId());
                    dto.setLivreTitre(ex.getIdLivre().getTitre());
                }
                dto.setExemplaires(List.of(exDto));
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
                    // Correction : construire un ExemplaireDTO pour la liste
                    Exemplaire ex = emp.getIdExemplaire();
                    ExemplaireDTO exDto = new ExemplaireDTO();
                    exDto.setId(ex.getId());
                    exDto.setQuantite(ex.getQuantite());
                    if (ex.getIdLivre() != null) {
                        exDto.setLivreId(ex.getIdLivre().getId());
                        exDto.setLivreTitre(ex.getIdLivre().getTitre());
                    }
                    dto.setExemplaires(List.of(exDto));
                    return dto;
                })
                .collect(Collectors.toList());
    }
}
