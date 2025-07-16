INSERT INTO Profils_Adherent (nom_profil, quota_emprunts_simultanes, jours_pret, reservation_livre, prolongement_pret, nb_jour_penalite) VALUES
                                                                                                                                             ('Etudiant', 2, 7, 1, 3, 10),
                                                                                                                                             ('Enseignant', 3, 9, 2, 5, 9),
                                                                                                                                             ('Professionnel', 4, 12, 3, 7, 8);
INSERT INTO Auteurs (nom, prenom) VALUES
                                      ('Hugo', 'Victor'),
                                      ('Camus', 'Albert'),
                                      ('Rowling', 'J.K.');
INSERT INTO Categories (nom) VALUES
                                 ('Littérature classique'),
                                 ('Philosophie'),
                                 ('Jeunesse / Fantastique');
INSERT INTO Livres (id_livre, titre, isbn, id_editeur) VALUES
                                                           (1, 'Les Misérables', '9782070409189', 1),
                                                           (2, 'L''Étranger', '9782070360022', 1),
                                                           (3, 'Harry Potter à l''école des sorciers', '9782070643026', 1);
INSERT INTO Livres_Auteurs (id_livre, id_auteur) VALUES
                                                     (1, 1),
                                                     (2, 2),
                                                     (3, 3);
INSERT INTO Livres_Categories (id_livre, id_categorie) VALUES
                                                           (1, 1),
                                                           (2, 2),
                                                           (3, 3);
INSERT INTO Exemplaires (id_livre, quantite) VALUES
                                                 (1, 3),
                                                 (2, 2),
                                                 (3, 1);
INSERT INTO Utilisateurs (email, mot_de_passe_hash) VALUES
                                                        ('amine.bensaid@biblio.com', '$2b$12$iXTYof235G9JADbPdni/BeANkjg7E/RJDrgWL5UwKs0sop8CVEXoS'),
                                                        ('sarah.elkhattabi@biblio.com', '$2b$12$iXTYof235G9JADbPdni/BeANkjg7E/RJDrgWL5UwKs0sop8CVEXoS'),
                                                        ('youssef.moujahid@biblio.com', '$2b$12$iXTYof235G9JADbPdni/BeANkjg7E/RJDrgWL5UwKs0sop8CVEXoS'),
                                                        ('nadia.benali@biblio.com', '$2b$12$iXTYof235G9JADbPdni/BeANkjg7E/RJDrgWL5UwKs0sop8CVEXoS'),
                                                        ('karim.haddadi@biblio.com', '$2b$12$iXTYof235G9JADbPdni/BeANkjg7E/RJDrgWL5UwKs0sop8CVEXoS'),
                                                        ('salima.touhami@biblio.com', '$2b$12$iXTYof235G9JADbPdni/BeANkjg7E/RJDrgWL5UwKs0sop8CVEXoS'),
                                                        ('rachid.elmansouri@biblio.com', '$2b$12$iXTYof235G9JADbPdni/BeANkjg7E/RJDrgWL5UwKs0sop8CVEXoS'),
                                                        ('amina.zerouali@biblio.com', '$2b$12$iXTYof235G9JADbPdni/BeANkjg7E/RJDrgWL5UwKs0sop8CVEXoS');
INSERT INTO Adherents (id_utilisateur, nom, prenom, date_naissance, id_profil, "NUMAdherent") VALUES
                                                                                                  (1, 'Bensaïd', 'Amine', '2000-01-01', (SELECT id_profil FROM Profils_Adherent WHERE nom_profil = 'Etudiant'), 'ETU001'),
                                                                                                  (2, 'El Khattabi', 'Sarah', '2000-01-01', (SELECT id_profil FROM Profils_Adherent WHERE nom_profil = 'Etudiant'), 'ETU002'),
                                                                                                  (3, 'Moujahid', 'Youssef', '2000-01-01', (SELECT id_profil FROM Profils_Adherent WHERE nom_profil = 'Etudiant'), 'ETU003'),
                                                                                                  (4, 'Benali', 'Nadia', '1980-01-01', (SELECT id_profil FROM Profils_Adherent WHERE nom_profil = 'Enseignant'), 'ENS001'),
                                                                                                  (5, 'Haddadi', 'Karim', '1982-01-01', (SELECT id_profil FROM Profils_Adherent WHERE nom_profil = 'Enseignant'), 'ENS002'),
                                                                                                  (6, 'Touhami', 'Salima', '1983-01-01', (SELECT id_profil FROM Profils_Adherent WHERE nom_profil = 'Enseignant'), 'ENS003'),
                                                                                                  (7, 'El Mansouri', 'Rachid', '1979-01-01', (SELECT id_profil FROM Profils_Adherent WHERE nom_profil = 'Professionnel'), 'PROF001'),
                                                                                                  (8, 'Zerouali', 'Amina', '1984-01-01', (SELECT id_profil FROM Profils_Adherent WHERE nom_profil = 'Professionnel'), 'PROF002');

INSERT INTO Abonnements (id_adherent, date_debut, date_fin) VALUES
                                                                ((SELECT id_adherent FROM Adherents WHERE "NUMAdherent" = 'ETU001'), '2025-02-01', '2025-07-24'),
                                                                ((SELECT id_adherent FROM Adherents WHERE "NUMAdherent" = 'ETU002'), '2025-02-01', '2025-07-01'),
                                                                ((SELECT id_adherent FROM Adherents WHERE "NUMAdherent" = 'ETU003'), '2025-04-01', '2025-12-01'),
                                                                ((SELECT id_adherent FROM Adherents WHERE "NUMAdherent" = 'ENS001'), '2025-07-01', '2026-07-01'),
                                                                ((SELECT id_adherent FROM Adherents WHERE "NUMAdherent" = 'ENS002'), '2025-08-01', '2026-05-01'),
                                                                ((SELECT id_adherent FROM Adherents WHERE "NUMAdherent" = 'ENS003'), '2025-07-01', '2026-06-01'),
                                                                ((SELECT id_adherent FROM Adherents WHERE "NUMAdherent" = 'PROF001'), '2025-06-01', '2025-12-01'),
                                                                ((SELECT id_adherent FROM Adherents WHERE "NUMAdherent" = 'PROF002'), '2024-10-01', '2025-06-01');
INSERT INTO Jours_Feries (date_ferie, description) VALUES
                                                       ('2025-07-13', 'Jour férié'),
                                                       ('2025-07-20', 'Jour férié'),
                                                       ('2025-07-26', 'Jour férié'),
                                                       ('2025-07-19', 'Jour férié'),
                                                       ('2025-07-27', 'Jour férié'),
                                                       ('2025-08-03', 'Jour férié'),
                                                       ('2025-08-10', 'Jour férié'),
                                                       ('2025-08-17', 'Jour férié');
