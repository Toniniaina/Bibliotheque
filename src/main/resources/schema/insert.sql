INSERT INTO Statuts_Emprunt (code_statut) VALUES
                                              ('emprunté'),     -- id = 1
                                              ('retourné'),     -- id = 2
                                              ('en retard'),    -- id = 3
                                              ('perdu');        -- id = 4
INSERT INTO Type_emprunts (nom_type) VALUES ('Domicile'); -- id = 1
-- Editeur
INSERT INTO Editeurs (nom) VALUES ('Gallimard'); -- id = 1

-- Livre
INSERT INTO Livres (titre, isbn, annee_publication, resume, id_editeur)
VALUES ('Le Petit Prince', '9782070612758', 1943, 'Conte philosophique.', 1); -- id = 1

-- Exemplaire
INSERT INTO Exemplaires (id_livre, quantite) VALUES (1, 5); -- id = 1
INSERT INTO Emprunts (
    id_exemplaire, id_adherent, id_type_emprunt, date_emprunt, date_retour_prevue
) VALUES (
             1, 6, 1, NOW() - INTERVAL '10 days', NOW() - INTERVAL '3 days'
         ); -- id_emprunt = 1
-- Emprunté
INSERT INTO Mvt_Emprunt (id_emprunt, id_statut_nouveau, date_mouvement)
VALUES (1, 1, NOW() - INTERVAL '10 days');

-- En retard
INSERT INTO Mvt_Emprunt (id_emprunt, id_statut_nouveau, date_mouvement)
VALUES (1, 3, NOW());
