create table profils_adherent
(
    id_profil                   serial
        primary key,
    nom_profil                  varchar(100)         not null
        unique,
    quota_emprunts_simultanes   integer default 3    not null,
    duree_pret_domicile_jours   integer default 21   not null,
    duree_pret_sur_place_heures integer default 3    not null,
    peut_prolonger_pret         boolean default true not null,
    jours_penalite_par_retard   integer default 1    not null
);

alter table profils_adherent
    owner to postgres;

create table auteurs
(
    id_auteur serial
        primary key,
    nom       varchar(100) not null,
    prenom    varchar(100)
);

alter table auteurs
    owner to postgres;

create table editeurs
(
    id_editeur serial
        primary key,
    nom        varchar(150) not null
        unique
);

alter table editeurs
    owner to postgres;

create table categories
(
    id_categorie serial
        primary key,
    nom          varchar(100) not null
        unique
);

alter table categories
    owner to postgres;

create table jours_feries
(
    date_ferie  date not null
        primary key,
    description varchar(255)
);

alter table jours_feries
    owner to postgres;

create table statuts_reservation
(
    id_statut   serial
        primary key,
    code_statut varchar(20) not null
        unique
);

alter table statuts_reservation
    owner to postgres;

create table livres
(
    id_livre          serial
        primary key,
    titre             varchar(255) not null,
    isbn              varchar(20)
        unique,
    annee_publication integer,
    resume            text,
    id_editeur        integer
        references editeurs
);

alter table livres
    owner to postgres;

create table utilisateurs
(
    id_utilisateur    serial
        primary key,
    email             varchar(255)                        not null
        unique,
    mot_de_passe_hash varchar(255)                        not null,
    date_creation     timestamp default CURRENT_TIMESTAMP not null
);

alter table utilisateurs
    owner to postgres;

create table adherents
(
    id_adherent      serial
        primary key,
    id_utilisateur   integer
        unique
        references utilisateurs,
    nom              varchar(100)              not null,
    prenom           varchar(100)              not null,
    telephone        varchar(20),
    date_inscription date default CURRENT_DATE not null,
    id_profil        integer                   not null
        references profils_adherent,
    date_naissance   date
);

alter table adherents
    owner to postgres;

create table bibliothecaires
(
    id_bibliothecaire serial
        primary key,
    id_utilisateur    integer      not null
        unique
        references utilisateurs,
    nom               varchar(100) not null,
    prenom            varchar(100) not null
);

alter table bibliothecaires
    owner to postgres;

create table livres_auteurs
(
    id_livre  integer not null
        references livres
            on delete cascade,
    id_auteur integer not null
        references auteurs
            on delete cascade,
    primary key (id_livre, id_auteur)
);

alter table livres_auteurs
    owner to postgres;

create table livres_categories
(
    id_livre     integer not null
        references livres
            on delete cascade,
    id_categorie integer not null
        references categories
            on delete cascade,
    primary key (id_livre, id_categorie)
);

alter table livres_categories
    owner to postgres;

create table exemplaires
(
    id_exemplaire serial
        primary key,
    id_livre      integer not null
        references livres
            on delete cascade,
    quantite      integer not null
);

alter table exemplaires
    owner to postgres;

create table abonnements
(
    id_abonnement serial
        primary key,
    id_adherent   integer not null
        references adherents,
    date_debut    date    not null,
    date_fin      date    not null
);

alter table abonnements
    owner to postgres;

create table droits_emprunt_specifiques
(
    id_droit                  serial
        primary key,
    id_livre                  integer              not null
        references livres
            on delete cascade,
    id_profil                 integer              not null
        references profils_adherent
            on delete cascade,
    emprunt_domicile_autorise boolean default true not null,
    age                       integer,
    unique (id_livre, id_profil)
);

alter table droits_emprunt_specifiques
    owner to postgres;

create table emprunts
(
    id_emprunt         serial
        primary key,
    id_exemplaire      integer                             not null
        references exemplaires,
    id_adherent        integer                             not null
        references adherents,
    date_emprunt       timestamp default CURRENT_TIMESTAMP not null,
    date_retour_prevue date                                not null,
    date_retour_reelle date,
    prolongations      integer   default 0
);

alter table emprunts
    owner to postgres;

create table reservations
(
    id_reservation  serial
        primary key,
    id_livre        integer                             not null
        references livres
            on delete cascade,
    id_adherent     integer                             not null
        references adherents
            on delete cascade,
    id_statut       integer   default 1                 not null
        references statuts_reservation,
    date_demande    timestamp default CURRENT_TIMESTAMP not null,
    date_expiration date                                not null
);

alter table reservations
    owner to postgres;

create table mvt_reservation
(
    id_mvt_reservation serial
        primary key,
    id_reservation     integer                             not null
        references reservations
            on delete cascade,
    id_statut_nouveau  integer                             not null
        references statuts_reservation,
    date_mouvement     timestamp default CURRENT_TIMESTAMP not null
);

alter table mvt_reservation
    owner to postgres;

create table penalites
(
    id_penalite serial
        primary key,
    id_emprunt  integer not null
        references emprunts,
    id_adherent integer not null
        references adherents,
    date_debut  date    not null,
    date_fin    date    not null,
    raison      varchar(255)
);

alter table penalites
    owner to postgres;

