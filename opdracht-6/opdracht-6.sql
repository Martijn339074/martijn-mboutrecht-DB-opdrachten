CREATE DATABASE IF NOT EXISTS UitgeverSys;
USE UitgeverSys;

CREATE TABLE Auteurs (
    AuteurId INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Auteur VARCHAR(100) NOT NULL,
    IsActief BOOLEAN NOT NULL DEFAULT TRUE,
    Opmerking VARCHAR(255),
    AangemaaktDatum DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    GewijzigdDatum DATETIME ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Uitgevers (
    UitgeverId INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Uitgever VARCHAR(100) NOT NULL,
    UitgeversAd VARCHAR(255) NOT NULL,
    IsActief BOOLEAN NOT NULL DEFAULT TRUE,
    Opmerking VARCHAR(255),
    AangemaaktDatum DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    GewijzigdDatum DATETIME ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Boeken (
    BoekId INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Titel VARCHAR(255) NOT NULL,
    AuteurId INT UNSIGNED NOT NULL,
    UitgeverId INT UNSIGNED NOT NULL,
    IsActief BOOLEAN NOT NULL DEFAULT TRUE,
    Opmerking VARCHAR(255),
    AangemaaktDatum DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    GewijzigdDatum DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (AuteurId) REFERENCES Auteurs(AuteurId),
    FOREIGN KEY (UitgeverId) REFERENCES Uitgevers(UitgeverId)
);

-- Stap 7: Vul elke tabel met minimaal 5 rijen gegevens
INSERT INTO Auteurs (Auteur) VALUES 
('J.R.R. Tolkien'),
('J.K. Rowling'),
('George Orwell'),
('Jane Austen'),
('Stephen King');

INSERT INTO Uitgevers (Uitgever, UitgeversAd) VALUES 
('HarperCollins', '123 Harper St, London'),
('Bloomsbury', '45 Bloomsbury Ave, London'),
('Penguin Books', '80 Strand, London'),
('Vintage Books', '20 Vauxhall Bridge Rd, London'),
('Scribner', '153-157 Fifth Avenue, New York');

INSERT INTO Boeken (Titel, AuteurId, UitgeverId) VALUES 
('De Hobbit', 1, 1),
('Harry Potter en de Steen der Wijzen', 2, 2),
('1984', 3, 3),
('Pride and Prejudice', 4, 4),
('The Shining', 5, 5),
('Lord of the Rings', 1, 1),
('Harry Potter en de Gevangene van Azkaban', 2, 2);

SELECT Titel 
FROM Boeken 
WHERE Titel LIKE '%zoekterm%' AND IsActief = TRUE;

SELECT Auteur 
FROM Auteurs 
WHERE Auteur LIKE '%voornaam%' 
  AND Auteur LIKE '%achternaam%' 
  AND (Auteur LIKE '%tussenvoegsel%' OR '%tussenvoegsel%' = '')
  AND IsActief = TRUE;

  SELECT Uitgever 
FROM Uitgevers 
WHERE Uitgever LIKE '%zoekterm%' AND IsActief = TRUE;

SELECT UitgeversAd 
FROM Uitgevers 
WHERE UitgeversAd LIKE '%zoekterm%' AND IsActief = TRUE;

SELECT b.Titel, a.Auteur, u.Uitgever, u.UitgeversAd
FROM Boeken b
JOIN Auteurs a ON b.AuteurId = a.AuteurId
JOIN Uitgevers u ON b.UitgeverId = u.UitgeverId
WHERE b.Titel LIKE '%boekzoekterm%'
  AND a.Auteur LIKE '%auteurzoekterm%'
  AND u.Uitgever LIKE '%uitgeverzoekterm%'
  AND u.UitgeversAd LIKE '%adreszoekterm%'
  AND b.IsActief = TRUE
  AND a.IsActief = TRUE
  AND u.IsActief = TRUE;