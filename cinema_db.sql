-- Création de un User aver des privileges
CREATE USER 'root'@'localhost' IDENTIFIED BY 'bfuig2874798GGh';

-- Création de la Base des données
CREATE DATABASE cinema_db;

-- Utilisation de la Base des données
USE cinema_db;

-- Création de la table ComplexCinematography
CREATE TABLE ComplexCinematography (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    adresse VARCHAR(255) NOT NULL
);

-- Création de la table SalledeCinema
CREATE TABLE SalledeCinema (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    capacite INT NOT NULL,
    id_complex INT,
    FOREIGN KEY (id_complex) REFERENCES ComplexCinematography(id)
);

-- Création de la table séance
CREATE TABLE Seance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_film INT,
    id_salle INT,
    id_complex INT,
    date_seance DATETIME,
    places_disponibles INT,
    FOREIGN KEY (id_film) REFERENCES Film(id),
    FOREIGN KEY (id_salle) REFERENCES SalledeCinema(id),
    FOREIGN KEY (id_complex) REFERENCES ComplexCinematography(id)
);

--Création de la table film
 CREATE TABLE Film (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    duree INT NOT NULL
);

-- Création de la table tarif
CREATE TABLE Tarif (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoire VARCHAR(50) NOT NULL,
    prix DECIMAL (5, 2) NOT NULL
);

-- Insertion des tarifs possibles
INSERT INTO Tarif (categoire, prix) VALUES
('Plein Tarif', 9.20),
('Étudiant', 7.60),
('Moins de 14 ans', 5.90);

-- Création de la table Utilisateur
CREATE TABLE Utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL, 
    email VARCHAR(100) NOT NULL,
    mot_de_passe VARCHAR(100) NOT NULL,
    est_admin BOOLEAN NOT NULL, 
    id_complex INT,
    FOREIGN KEY (id_complex) REFERENCES ComplexCinematography(id)
);

-- Création de la table Reservation
CREATE TABLE Reservation(
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_seance INT, 
    id_utilisateur INT,
    nombre_places INT,
    prix_total DECIMAL (5, 2),
    paye_en_ligne BOOLEAN,
    FOREIGN KEY (id_seance) REFERENCES Seance(id),
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateur(id)
);

-- Insértion de Complex Cinematography
INSERT INTO ComplexCinematography (nom, adresse) VALUES
('Cinema ABC', '123 Rue du Cinema, Paris'),
('Cinema Tous', '12 Rue pour Tous, Lyon'),
('Cinema Movie', '55 Rue de la film, Nantes'),
('Cinema Action', '40 Avenue Cine, Bordeaux');

-- Insértion des Salles de cinema
INSERT INTO SalledeCinema (nom, capacite, id_complex) VALUES
('Salle 1', 100, 1),
('Salle 1', 120, 2),
('Salle 1', 80, 3),
('Salle 1', 130, 4),
('Salle 2', 130, 1),
('Salle 2', 80, 2),
('Salle 2', 120, 3),
('Salle 2', 100, 4),
('Salle 3', 100, 1),
('Salle 3', 120, 2),
('Salle 3', 80, 3),
('Salle 3', 130, 4),
('Salle 4', 100, 1),
('Salle 4', 120, 2),
('Salle 4', 90, 3),
('Salle 4', 100, 4);

-- Insertion des utilisateurs (administrateurs)
INSERT INTO Utilisateur (nom, email, mot_de_passe, est_admin, id_complex) VALUES 
('Tomas', 'tomas@cine.com', SHA2('tomtom', 256), true, 1),
('Nicolas', 'nico@cine.com', SHA2('niconico', 256), true, 1)
('Macarena', 'maca@cine.com', SHA2('macamaca', 256), true, 3),
('Gustavo', 'gusgus@cine.com', SHA2('gusgus', 256), true, 4);

INSERT INTO Utilisateur (nom, email, mot_de_passe, est_admin, id_complex) VALUES 
('Agustina', 'tini@cine.com', SHA2('agusagus', 256), false, 1),
('Gonzalo', 'gonza@cine.com', SHA2('gonzagonza', 256), false, 2),
('Facundo', 'facu@cine.com', SHA2('facufacu', 256), false, 3),
('Federica', 'fede@cine.com', SHA2('fedefede', 256), false, 4);

--Insertion films
INSERT INTO Film (titre, duree) VALUES
('El despertar del amanecer', 120),
('La ciudad eterna', 105),
('Misterios del mar', 90),
('El camino del héroe', 110),
('Secretos en la montaña', 95),
('La sombra del pasado', 125),
('Travesía intergaláctica', 100),
('Aventuras en la jungla', 115);

-- Insertion de séances
INSERT INTO Seance (id_film, id_salle, id_complex, date_seance, places_disponibles) VALUES 
(1, 1, 1, '2024-05-03 18:00:00', 100),
(2, 2, 2, '2024-05-03 20:00:00', 60),
(3, 3, 3, '2024-05-04 17:00:00', 80),
(4, 4, 4, '2024-05-04 17:00:00', 100),
(1, 2, 2, '2024-05-04 17:00:00', 180),
(2, 3, 3, '2024-05-04 19:00:00', 76),
(3, 4, 4, '2024-05-04 21:00:00', 100),
(4, 1, 1, '2024-05-04 22:00:00', 10);

-- Insertion de réservations
INSERT INTO Reservation (id_seance, id_utilisateur, nombre_places, prix_total, paye_en_ligne) VALUES 
(1, 3, 2, 18.40, false),
(2, 4, 3, 22.80, true),
(3, 5, 1, 9.20, false),
(4, 6, 2, 15.20, true);


+------------------+        +------------------+        +---------------------+         +------------+
|    ComplexCinematography  |    SalledeCinema |       |      Seance          |          |    Film       |
+------------------+        +------------------+        +---------------------+         +------------+
| - id: int          |      | - id: int               | - id: int             |          | - id: int      |
| - nom: string      |      | - nom: string           | - id_film: int        |          | - titre: string|
| - adresse: string  |      | - capacite: int         | - id_salle: int       |          | - duree: int   |
|                           | - id_complex: int       | - id_complex: int              +------------+
+------------------+        +------------------+        +---------------------+          
       |                                       |                                       |
       |                                       |                                       |
       |                                       |                                       |
       |                                       |                                       |
       v                                       v                                       v
+-------------------+         +------------------+         +-------------------+
|      Utilisateur|         |       Reservation          ||       Tarif       |
+-------------------+         +------------------+         +-------------------+
| - id: int        |         | - id: int       |          | - id: int       |
| - nom: string    |         | - id_seance: int|          | - categoire: string|
| - email: string  |         | - id_utilisateur: int      | - prix: decimal |
| - mot_de_passe: string|    | - nombre_places: int|          +-------------------+
| - est_admin: bool|         | - prix_total: decimal|
| - id_complex: int|         | - paye_en_ligne: bool |
+-------------------+         +------------------+






