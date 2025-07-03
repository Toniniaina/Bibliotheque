-- ===== UNITÉS, RACES, SEXES, DÉPARTEMENTS, RÔLES, ÉTATS D'ŒUFS =====

CREATE TABLE unite (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       nom VARCHAR(100) NOT NULL UNIQUE,
                       abreviation VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE race_poule (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            nom VARCHAR(100) NOT NULL UNIQUE,
                            duree_vie_moyenne INT NOT NULL,
                            age_ponte_debut INT NOT NULL,
                            ponte_par_jour DECIMAL(3,2)
);

CREATE TABLE sexe (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      libelle VARCHAR(50) NOT NULL UNIQUE,
                      abreviation VARCHAR(10) NOT NULL UNIQUE
);

CREATE TABLE departement (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             nom VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE role (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      description TEXT NOT NULL
);

CREATE TABLE etat_oeuf (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           description TEXT NOT NULL
);

-- ===== TYPE DE MOUVEMENT =====

CREATE TABLE type_mouvement (
                                id INT AUTO_INCREMENT PRIMARY KEY,
                                description VARCHAR(100) NOT NULL
);

-- ===== GESTION DES EMPLOYÉS =====

CREATE TABLE employe (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         nom VARCHAR(100) NOT NULL,
                         prenom VARCHAR(100) NOT NULL,
                         dtn DATE NOT NULL,
                         id_sexe INT,
                         email VARCHAR(100) NOT NULL UNIQUE,
                         mdp VARCHAR(255) NOT NULL,
                         id_role INT,
                         actif BOOLEAN DEFAULT 1,
                         CONSTRAINT fk_employe_sexe FOREIGN KEY (id_sexe) REFERENCES sexe(id),
                         CONSTRAINT fk_employe_role FOREIGN KEY (id_role) REFERENCES role(id)
);

CREATE TABLE employe_type_mouvement (
                                        id INT AUTO_INCREMENT PRIMARY KEY,
                                        description VARCHAR(100)
);

CREATE TABLE employe_mouvement (
                                   id INT AUTO_INCREMENT PRIMARY KEY,
                                   id_employe INT NOT NULL,
                                   id_employe_type_mouvement INT NOT NULL,
                                   date_mouvement DATE NOT NULL,
                                   CONSTRAINT fk_employe_mouvement_employe FOREIGN KEY (id_employe) REFERENCES employe(id),
                                   CONSTRAINT fk_employe_mouvement_type FOREIGN KEY (id_employe_type_mouvement) REFERENCES employe_type_mouvement(id)
);

CREATE TABLE salaire (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         montant DECIMAL(10,2) NOT NULL,
                         date_debut DATE NOT NULL,
                         id_employe INT,
                         CONSTRAINT fk_salaire_employe FOREIGN KEY (id_employe) REFERENCES employe(id)
);

CREATE TABLE payment_salaire (
                                 id INT AUTO_INCREMENT PRIMARY KEY,
                                 id_employe INT,
                                 id_salaire INT,
                                 date_payment DATE NOT NULL,
                                 montant_paye DECIMAL(10,2) NOT NULL,
                                 CONSTRAINT fk_payment_salaire_employe FOREIGN KEY (id_employe) REFERENCES employe(id),
                                 CONSTRAINT fk_payment_salaire_salaire FOREIGN KEY (id_salaire) REFERENCES salaire(id)
);

-- ===== GESTION DES CAGES ET PROMOTIONS =====

CREATE TABLE cage (
                      id INT AUTO_INCREMENT PRIMARY KEY,
                      nom VARCHAR(50),
                      description TEXT,
                      capacite INT NOT NULL,
                      actif BOOLEAN DEFAULT 1
);

CREATE TABLE promotion (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           nom VARCHAR(100) NOT NULL,
                           age_arrivee INT NOT NULL DEFAULT 0,
                           nombre INT NOT NULL,
                           id_race_poule INT,
                           poids_moyen DECIMAL(5,2),
                           CONSTRAINT fk_promotion_race FOREIGN KEY (id_race_poule) REFERENCES race_poule(id)
);

CREATE TABLE promotion_achat (
                                 id INT AUTO_INCREMENT PRIMARY KEY,
                                 id_promotion INT NOT NULL,
                                 prix_achat_unitaire DECIMAL(10,2),
                                 date_arrivee DATE NOT NULL,
                                 id_employe_responsable INT,
                                 validation BOOLEAN DEFAULT 0,
                                 CONSTRAINT fk_promotion_achat_employe FOREIGN KEY (id_employe_responsable) REFERENCES employe(id),
                                 CONSTRAINT fk_promotion_achat_promotion FOREIGN KEY (id_promotion) REFERENCES promotion(id)
);

CREATE TABLE promotion_cage_mouvement (
                                          id INT AUTO_INCREMENT PRIMARY KEY,
                                          id_cage INT,
                                          id_promotion INT,
                                          id_type_mouvement INT,
                                          nombre_poule INT NOT NULL,
                                          date_mouvement DATE NOT NULL,
                                          observation TEXT,
                                          CONSTRAINT fk_cage_mouvement_cage FOREIGN KEY (id_cage) REFERENCES cage(id),
                                          CONSTRAINT fk_cage_mouvement_promotion FOREIGN KEY (id_promotion) REFERENCES promotion(id),
                                          CONSTRAINT fk_cage_mouvement_type FOREIGN KEY (id_type_mouvement) REFERENCES type_mouvement(id)
);

CREATE TABLE cage_etat (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           id_cage INT,
                           date_etat DATE NOT NULL,
                           description TEXT NOT NULL,
                           CONSTRAINT fk_cage_etat_cage FOREIGN KEY (id_cage) REFERENCES cage(id)
);

CREATE TABLE promotion_mort (
                                id INT AUTO_INCREMENT PRIMARY KEY,
                                id_promotion INT,
                                nb_poule INT NOT NULL,
                                date_mort DATE NOT NULL,
                                cause_mort TEXT,
                                CONSTRAINT fk_promotion_mort FOREIGN KEY (id_promotion) REFERENCES promotion(id)
);

-- ===== GESTION DES PROVENDES =====

CREATE TABLE provende (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          nom VARCHAR(100) NOT NULL UNIQUE,
                          id_unite INT,
                          stock_minimum DECIMAL(10,2) DEFAULT 0,
                          CONSTRAINT fk_provende_unite FOREIGN KEY (id_unite) REFERENCES unite(id)
);

CREATE TABLE provende_achat (
                                id INT AUTO_INCREMENT PRIMARY KEY,
                                id_provende INT,
                                date_achat DATE NOT NULL,
                                quantite DECIMAL(10,2) NOT NULL,
                                prix_unitaire DECIMAL(10,2) DEFAULT NULL,
                                id_employe INT,
                                observation TEXT,
                                date_expiration DATE NOT NULL,
                                validation BOOLEAN DEFAULT 0,
                                CONSTRAINT fk_provende_achat_provende FOREIGN KEY (id_provende) REFERENCES provende(id),
                                CONSTRAINT fk_provende_achat_employe FOREIGN KEY (id_employe) REFERENCES employe(id)
);

CREATE TABLE provende_race (
                               id INT AUTO_INCREMENT PRIMARY KEY,
                               id_provende INT,
                               id_race_poule INT,
                               age_debut INT NOT NULL,
                               age_fin INT NOT NULL,
                               quantite_recommandee DECIMAL(10,2) NOT NULL,
                               CONSTRAINT fk_provende_race_provende FOREIGN KEY (id_provende) REFERENCES provende(id),
                               CONSTRAINT fk_provende_race_race FOREIGN KEY (id_race_poule) REFERENCES race_poule(id)
);

CREATE TABLE promotion_alimentation (
                                        id INT AUTO_INCREMENT PRIMARY KEY,
                                        id_promotion INT,
                                        id_provende INT,
                                        date_alimentation DATE NOT NULL,
                                        quantite_donnee DECIMAL(10,2) NOT NULL,
                                        id_employe INT,
                                        validation BOOLEAN DEFAULT 0,
                                        CONSTRAINT fk_alimentation_promotion FOREIGN KEY (id_promotion) REFERENCES promotion(id),
                                        CONSTRAINT fk_alimentation_provende FOREIGN KEY (id_provende) REFERENCES provende(id),
                                        CONSTRAINT fk_alimentation_employe FOREIGN KEY (id_employe) REFERENCES employe(id)
);

-- ===== GESTION DES MÉDICAMENTS =====

CREATE TABLE medicament (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            nom VARCHAR(100) NOT NULL UNIQUE,
                            id_unite INT,
                            stock_minimum DECIMAL(10,2) DEFAULT 0,
                            CONSTRAINT fk_medicament_unite FOREIGN KEY (id_unite) REFERENCES unite(id)
);

CREATE TABLE medicament_achat (
                                  id INT AUTO_INCREMENT PRIMARY KEY,
                                  id_medicament INT,
                                  date_achat DATE NOT NULL,
                                  quantite DECIMAL(10,2) NOT NULL,
                                  prix_unitaire DECIMAL(10,2) DEFAULT NULL,
                                  id_employe INT,
                                  description TEXT,
                                  validation BOOLEAN DEFAULT 0,
                                  CONSTRAINT fk_medicament_achat_medicament FOREIGN KEY (id_medicament) REFERENCES medicament(id),
                                  CONSTRAINT fk_medicament_achat_mouvement FOREIGN KEY (id_type_mouvement) REFERENCES type_mouvement(id),
                                  CONSTRAINT fk_medicament_achat_employe FOREIGN KEY (id_employe) REFERENCES employe(id)
);

CREATE TABLE medicament_administration (
                                           id INT AUTO_INCREMENT PRIMARY KEY,
                                           id_medicament INT NOT NULL,
                                           id_promotion INT NOT NULL,
                                           date_administration DATE,
                                           id_employe INT,
                                           validation BOOLEAN DEFAULT 0,
                                           CONSTRAINT fk_admin_medicament FOREIGN KEY (id_medicament) REFERENCES medicament(id),
                                           CONSTRAINT fk_admin_promotion FOREIGN KEY (id_promotion) REFERENCES promotion(id),
                                           CONSTRAINT fk_admin_employe FOREIGN KEY (id_employe) REFERENCES employe(id)
);

CREATE TABLE frequence (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           description VARCHAR(100) NOT NULL
);

CREATE TABLE medicament_race (
                                 id INT AUTO_INCREMENT PRIMARY KEY,
                                 id_medicament INT,
                                 id_race_poule INT,
                                 id_frequence INT,
                                 age_debut INT NOT NULL,
                                 age_fin INT DEFAULT NULL,
                                 quantite_par_poule DECIMAL(10,2) NOT NULL,
                                 obligatoire BOOLEAN DEFAULT 0,
                                 CONSTRAINT fk_medicament_race_medicament FOREIGN KEY (id_medicament) REFERENCES medicament(id),
                                 CONSTRAINT fk_medicament_race_race FOREIGN KEY (id_race_poule) REFERENCES race_poule(id),
                                 CONSTRAINT fk_medicament_race_frequence FOREIGN KEY (id_frequence) REFERENCES frequence(id)
);

-- ===== GESTION DES ŒUFS =====

CREATE TABLE recolte (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         id_promotion INT,
                         id_etat_oeuf INT,
                         nombre_oeuf INT NOT NULL,
                         date_recolte DATE NOT NULL,
                         id_employe INT,
                         observation TEXT,
                         CONSTRAINT fk_recolte_promotion FOREIGN KEY (id_promotion) REFERENCES promotion(id),
                         CONSTRAINT fk_recolte_etat FOREIGN KEY (id_etat_oeuf) REFERENCES etat_oeuf(id),
                         CONSTRAINT fk_recolte_employe FOREIGN KEY (id_employe) REFERENCES employe(id)
);

CREATE TABLE prix_oeuf (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           id_etat_oeuf INT,
                           montant DECIMAL(10,2) NOT NULL,
                           date_prix DATE NOT NULL,
                           CONSTRAINT fk_prix_oeuf_etat FOREIGN KEY (id_etat_oeuf) REFERENCES etat_oeuf(id)
);

-- ===== GESTION DES VENTES =====

CREATE TABLE client (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        nom VARCHAR(100) NOT NULL,
                        telephone VARCHAR(20),
                        email VARCHAR(100),
                        adresse TEXT,
                        actif BOOLEAN DEFAULT 1
);

CREATE TABLE type_vente (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            produit VARCHAR(100) NOT NULL,
                            id_unite INT NOT NULL,
                            CONSTRAINT fk_type_vente_unite FOREIGN KEY (id_unite) REFERENCES unite(id)
);

CREATE TABLE vente (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       id_client INT,
                       id_type_vente INT,
                       quantite DECIMAL(10,2) NOT NULL,
                       prix_unitaire DECIMAL(10,2) NOT NULL,
                       date_vente DATE NOT NULL,
                       id_employe INT,
                       paye BOOLEAN DEFAULT 0,
                       date_payment DATE DEFAULT NULL,
                       validation BOOLEAN DEFAULT 0,
                       CONSTRAINT fk_vente_client FOREIGN KEY (id_client) REFERENCES client(id),
                       CONSTRAINT fk_vente_type FOREIGN KEY (id_type_vente) REFERENCES type_vente(id),
                       CONSTRAINT fk_vente_employe FOREIGN KEY (id_employe) REFERENCES employe(id)
);

-- ===== GESTION FINANCIÈRE =====

CREATE TABLE depense (
                         id INT AUTO_INCREMENT PRIMARY KEY,
                         description TEXT NOT NULL,
                         montant DECIMAL(10,2) NOT NULL,
                         date_depense DATE NOT NULL,
                         categorie VARCHAR(50) NOT NULL,
                         id_employe INT,
                         validation BOOLEAN DEFAULT 0,
                         CONSTRAINT fk_depense_employe FOREIGN KEY (id_employe) REFERENCES employe(id)
);

-- ===== SUIVI EMPLOYÉ-POULES =====

CREATE TABLE nb_poule_par_employe (
                                      id INT AUTO_INCREMENT PRIMARY KEY,
                                      id_employe INT,
                                      id_promotion INT,
                                      nb_poule_responsable INT NOT NULL,
                                      date_debut DATE NOT NULL,
                                      date_fin DATE DEFAULT NULL,
                                      actif BOOLEAN DEFAULT 1,
                                      CONSTRAINT fk_poule_employe FOREIGN KEY (id_employe) REFERENCES employe(id),
                                      CONSTRAINT fk_poule_promotion FOREIGN KEY (id_promotion) REFERENCES promotion(id)
);

-- ===== COMMANDE CLIENT =====

CREATE TABLE commande_etat (
                               id INT AUTO_INCREMENT PRIMARY KEY,
                               etat VARCHAR(50) NOT NULL
);

CREATE TABLE commande (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          date_commande DATE NOT NULL,
                          nombre_oeuf INT,
                          id_client INT,
                          id_etat INT,
                          CONSTRAINT fk_commande_etat FOREIGN KEY (id_etat) REFERENCES commande_etat(id),
                          CONSTRAINT fk_commande_client FOREIGN KEY (id_client) REFERENCES client(id)
);
