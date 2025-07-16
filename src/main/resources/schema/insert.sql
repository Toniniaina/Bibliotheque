-- -- INSERT INTO Statuts_Emprunt (code_statut) VALUES
-- --                                               ('emprunté'),     -- id = 1
-- --                                               ('retourné'),     -- id = 2
-- --                                               ('en retard'),    -- id = 3
-- --                                               ('perdu');        -- id = 4
-- -- INSERT INTO Type_emprunts (nom_type) VALUES ('Domicile'); -- id = 1
-- -- -- Editeur
-- -- INSERT INTO Editeurs (nom) VALUES ('Gallimard'); -- id = 1
-- --
-- -- -- Livre
-- -- INSERT INTO Livres (titre, isbn, annee_publication, resume, id_editeur)
-- -- VALUES ('Le Petit Prince', '9782070612758', 1943, 'Conte philosophique.', 1); -- id = 1
-- --
-- -- -- Exemplaire
-- -- INSERT INTO Exemplaires (id_livre, quantite) VALUES (1, 5); -- id = 1
-- -- INSERT INTO Emprunts (
-- --     id_exemplaire, id_adherent, id_type_emprunt, date_emprunt, date_retour_prevue
-- -- ) VALUES (
-- --              1, 6, 1, NOW() - INTERVAL '10 days', NOW() - INTERVAL '3 days'
-- --          ); -- id_emprunt = 1
-- -- -- Emprunté
-- -- INSERT INTO Mvt_Emprunt (id_emprunt, id_statut_nouveau, date_mouvement)
-- -- VALUES (1, 1, NOW() - INTERVAL '10 days');
-- --
-- -- -- En retard
-- -- INSERT INTO Mvt_Emprunt (id_emprunt, id_statut_nouveau, date_mouvement)
-- -- VALUES (1, 3, NOW());
-- -- create table validation_prolongement
-- -- (
-- --     id_validation        serial primary key,
-- --     id_prolongement      integer not null
-- --         references prolongements(id_prolongement)
-- --             on delete cascade,
-- --     date_validation      date not null,
-- --     valide               boolean not null
-- -- );
-- --
-- -- alter table validation_prolongement
-- --     owner to postgres;
--
-- -- create database bibliotheque;
-- -- \c bibliotheque;
-- create table profils_adherent
-- (
--     id_profil                 serial
--         primary key,
--     nom_profil                varchar(100)      not null
--         unique,
--     quota_emprunts_simultanes integer default 3 not null,
--     jours_pret                integer,
--     reservation_livre         integer,
--     prolongement_pret         integer,
--     nb_jour_penalite          integer
-- );
--
-- alter table profils_adherent
--     owner to postgres;
--
-- alter table profils_adherent
--     owner to postgres;
--
--
-- CREATE TABLE Auteurs (
--                          id_auteur SERIAL PRIMARY KEY,
--                          nom VARCHAR(100) NOT NULL,
--                          prenom VARCHAR(100)
-- );
--
-- CREATE TABLE Editeurs (
--                           id_editeur SERIAL PRIMARY KEY,
--                           nom VARCHAR(150) NOT NULL UNIQUE
-- );
--
-- CREATE TABLE Categories (
--                             id_categorie SERIAL PRIMARY KEY,
--                             nom VARCHAR(100) NOT NULL UNIQUE
-- );
--
-- CREATE TABLE Jours_Feries (
--                               date_ferie DATE PRIMARY KEY,
--                               description VARCHAR(255)
-- );
--
--
--
-- CREATE TABLE Statuts_Reservation (
--                                      id_statut SERIAL PRIMARY KEY,
--                                      code_statut VARCHAR(20) NOT NULL UNIQUE
-- );
--
-- -- 3. Création des tables principales
-- CREATE TABLE Livres (
--                         id_livre SERIAL PRIMARY KEY,
--                         titre VARCHAR(255) NOT NULL,
--                         isbn VARCHAR(20) UNIQUE,
--                         annee_publication INT,
--                         resume TEXT,
--                         id_editeur INT,
--                         FOREIGN KEY (id_editeur) REFERENCES Editeurs(id_editeur)
-- );
--
-- CREATE TABLE Utilisateurs (
--                               id_utilisateur SERIAL PRIMARY KEY,
--                               email VARCHAR(255) NOT NULL UNIQUE,
--                               mot_de_passe_hash VARCHAR(255) NOT NULL,
--                               date_creation TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
-- );
--
-- -- 4. Création des tables liées aux utilisateurs
-- create table adherents
-- (
--     id_adherent      serial
--         primary key,
--     id_utilisateur   integer
--         unique
--         references utilisateurs,
--     nom              varchar(100)              not null,
--     prenom           varchar(100)              not null,
--     date_naissance   date                      not null,
--     date_inscription date default CURRENT_DATE not null,
--     id_profil        integer                   not null
--         references profils_adherent,
--     "NUMAdherent"    varchar
-- );
--
-- alter table adherents
--     owner to postgres;
--
-- CREATE TABLE Bibliothecaires (
--                                  id_bibliothecaire SERIAL PRIMARY KEY,
--                                  id_utilisateur INT UNIQUE NOT NULL,
--                                  nom VARCHAR(100) NOT NULL,
--                                  prenom VARCHAR(100) NOT NULL,
--                                  FOREIGN KEY (id_utilisateur) REFERENCES Utilisateurs(id_utilisateur)
-- );
--
-- -- 5. Création des tables de liaison
-- CREATE TABLE Livres_Auteurs (
--                                 id_livre INT NOT NULL,
--                                 id_auteur INT NOT NULL,
--                                 PRIMARY KEY (id_livre, id_auteur),
--                                 FOREIGN KEY (id_livre) REFERENCES Livres(id_livre) ON DELETE CASCADE,
--                                 FOREIGN KEY (id_auteur) REFERENCES Auteurs(id_auteur) ON DELETE CASCADE
-- );
--
-- CREATE TABLE Livres_Categories (
--                                    id_livre INT NOT NULL,
--                                    id_categorie INT NOT NULL,
--                                    PRIMARY KEY (id_livre, id_categorie),
--                                    FOREIGN KEY (id_livre) REFERENCES Livres(id_livre) ON DELETE CASCADE,
--                                    FOREIGN KEY (id_categorie) REFERENCES Categories(id_categorie) ON DELETE CASCADE
-- );
--
-- -- 6. Création des tables de transactions
-- CREATE TABLE Exemplaires (
--                              id_exemplaire SERIAL PRIMARY KEY,
--                              id_livre INT NOT NULL,
--                              quantite INT NOT NULL,
--                              FOREIGN KEY (id_livre) REFERENCES Livres(id_livre) ON DELETE CASCADE
-- );
--
-- CREATE TABLE Abonnements (
--                              id_abonnement SERIAL PRIMARY KEY,
--                              id_adherent INT NOT NULL,
--                              date_debut DATE NOT NULL,
--                              date_fin DATE NOT NULL,
--                              FOREIGN KEY (id_adherent) REFERENCES Adherents(id_adherent)
-- );
--
-- CREATE TABLE Droits_Emprunt_Specifiques (
--                                             id_droit SERIAL PRIMARY KEY,
--                                             id_livre INT NOT NULL,
--                                             id_profil INT NOT NULL,
--                                             age INT ,
--                                             emprunt_surplace_autorise BOOLEAN NOT NULL DEFAULT TRUE,
--                                             emprunt_domicile_autorise BOOLEAN NOT NULL DEFAULT TRUE,
--                                             UNIQUE (id_livre, id_profil),
--                                             FOREIGN KEY (id_livre) REFERENCES Livres(id_livre) ON DELETE CASCADE,
--                                             FOREIGN KEY (id_profil) REFERENCES Profils_Adherent(id_profil) ON DELETE CASCADE
-- );
--
--
-- CREATE TABLE Type_emprunts(
--                               id_type_emprunt SERIAL PRIMARY KEY,
--                               nom_type VARCHAR(50)
-- );
--
-- CREATE TABLE Emprunts (
--                           id_emprunt SERIAL PRIMARY KEY,
--                           id_exemplaire INT NOT NULL,
--                           id_adherent INT NOT NULL,
--                           id_type_emprunt INT NOT NULL,
--                           date_emprunt TIMESTAMP NOT NULL,
--                           date_retour_prevue TIMESTAMP NOT NULL,
--                           FOREIGN KEY (id_type_emprunt) REFERENCES Type_emprunts(id_type_emprunt),
--                           FOREIGN KEY (id_exemplaire) REFERENCES Exemplaires(id_exemplaire),
--                           FOREIGN KEY (id_adherent) REFERENCES Adherents(id_adherent)
-- );
-- CREATE TABLE Statuts_Emprunt (
--                                  id_statut SERIAL PRIMARY KEY,
--                                  code_statut VARCHAR(20) NOT NULL UNIQUE
-- );
-- CREATE TABLE Mvt_Emprunt (
--                              id_mvt_emprunt SERIAL PRIMARY KEY,
--                              id_emprunt INT NOT NULL,
--                              id_statut_nouveau INT NOT NULL, -- Le statut vers lequel l'emprunt a transité
--                              date_mouvement TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--                              FOREIGN KEY (id_emprunt) REFERENCES Emprunts(id_emprunt) ON DELETE CASCADE,
--                              FOREIGN KEY (id_statut_nouveau) REFERENCES Statuts_Emprunt(id_statut)
-- );
--
-- CREATE TABLE Reservations (
--                               id_reservation SERIAL PRIMARY KEY,
--                               id_livre INT NOT NULL,
--                               id_adherent INT NOT NULL,
--                               id_statut INT NOT NULL DEFAULT 1,
--                               date_demande TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--                               date_expiration DATE NOT NULL,
--                               FOREIGN KEY (id_livre) REFERENCES Livres(id_livre) ON DELETE CASCADE,
--                               FOREIGN KEY (id_adherent) REFERENCES Adherents(id_adherent) ON DELETE CASCADE,
--                               FOREIGN KEY (id_statut) REFERENCES Statuts_Reservation(id_statut)
-- );
--
-- CREATE TABLE Mvt_Reservation (
--                                  id_mvt_reservation SERIAL PRIMARY KEY,
--                                  id_reservation INT NOT NULL,
--                                  id_statut_nouveau INT NOT NULL, -- Le statut vers lequel la réservation a transité
--                                  date_mouvement TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
--                                  FOREIGN KEY (id_reservation) REFERENCES Reservations(id_reservation) ON DELETE CASCADE,
--                                  FOREIGN KEY (id_statut_nouveau) REFERENCES Statuts_Reservation(id_statut)
-- );
--
--
--
-- CREATE TABLE Penalites (
--                            id_penalite SERIAL PRIMARY KEY,
--                            id_emprunt INT NOT NULL,
--                            id_adherent INT NOT NULL,
--                            date_debut DATE NOT NULL,
--                            jour INT NOT NULL,
--                            raison VARCHAR(255),
--                            FOREIGN KEY (id_emprunt) REFERENCES Emprunts(id_emprunt),
--                            FOREIGN KEY (id_adherent) REFERENCES Adherents(id_adherent)
-- );
-- INSERT INTO Profils_Adherent (nom_profil, quota_emprunts_simultanes) VALUES
--                                                                          ('Étudiant', 3),
--                                                                          ('Professeur', 5),
--                                                                          ('Chercheur', 4),
--                                                                          ('Personnel administratif', 2),
--                                                                          ('Visiteur', 1);
-- INSERT INTO Statuts_Emprunt (code_statut) VALUES
--                                               ('emprunté'),     -- id = 1
--                                               ('retourné'),     -- id = 2
--                                               ('en retard'),    -- id = 3
--                                               ('perdu');        -- id = 4
-- INSERT INTO Type_emprunts (nom_type) VALUES ('Domicile'); -- id = 1
-- -- Editeur
--
--
-- -- En retard
-- CREATE TABLE Prolongements (
--                                id_prolongement SERIAL PRIMARY KEY,
--                                id_emprunt INT NOT NULL,
--                                date_fin DATE NOT NULL,
--                                date_prolongement DATE NOT NULL,
--                                FOREIGN KEY (id_emprunt) REFERENCES Emprunts(id_emprunt) ON DELETE CASCADE
-- );
-- create table validation_prolongement
-- (
--     id_validation        serial primary key,
--     id_prolongement      integer not null
--         references prolongements(id_prolongement)
--             on delete cascade,
--     date_validation      date not null,
--     valide               boolean not null
-- );
--
-- alter table validation_prolongement
--     owner to postgres;
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
