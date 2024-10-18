
DROP DATABASE IF EXISTS BestellingSys;
CREATE DATABASE BestellingSys;
USe BestellingSys

-- Klant tabel
CREATE TABLE Klant (
    KlantID INT PRIMARY KEY AUTO_INCREMENT,
    KlantNaam VARCHAR(100) NOT NULL,
    IsActief BIT DEFAULT 1,
    Opmerking TEXT,
    AangemaaktDatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    GewijzigdDatum DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bestelling tabel
CREATE TABLE Bestelling (
    BestellingID INT PRIMARY KEY AUTO_INCREMENT,
    KlantID INT NOT NULL,
    IsActief BIT DEFAULT 1,
    Opmerking TEXT,
    AangemaaktDatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    GewijzigdDatum DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (KlantID) REFERENCES Klant(KlantID)
);

-- Product tabel
CREATE TABLE Product (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductNaam VARCHAR(100) NOT NULL,
    Prijs DECIMAL(10,2) NOT NULL,
    IsActief BIT DEFAULT 1,
    Opmerking TEXT,
    AangemaaktDatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    GewijzigdDatum DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- BestellingProduct tabel
CREATE TABLE BestellingProduct (
    BestellingID INT,
    ProductID INT,
    Aantal INT NOT NULL,
    PRIMARY KEY (BestellingID, ProductID),
    FOREIGN KEY (BestellingID) REFERENCES Bestelling(BestellingID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- Gegevens invoegen in Klant tabel
INSERT INTO Klant (KlantNaam, IsActief, Opmerking) VALUES
('Jan de Vries', TRUE, 'Vaste klant'),
('Piet van der Meer', TRUE, 'Nieuwe klant'),
('Anna Jansen', TRUE, 'Preferred customer'),
('Erik van Dijk', FALSE, 'Inactieve klant'),
('Maria de Boer', TRUE, 'Zakelijke klant');

-- Gegevens invoegen in Product tabel
INSERT INTO Product (ProductNaam, Prijs, IsActief, Opmerking) VALUES
('Laptop', 999.99, TRUE, 'Bestseller'),
('Smartphone', 599.99, TRUE, 'Nieuw model'),
('Tablet', 299.99, TRUE, 'Op voorraad'),
('Smartwatch', 199.99, FALSE, 'Uitlopend model'),
('Draadloze Koptelefoon', 149.99, TRUE, 'Populair item');

-- Gegevens invoegen in Bestelling tabel
INSERT INTO Bestelling (KlantID, IsActief, Opmerking) VALUES
(1, TRUE, 'Spoedbestelling'),
(2, TRUE, 'Standaard levering'),
(3, TRUE, 'Geschenkverpakking'),
(4, FALSE, 'Geannuleerd'),
(5, TRUE, 'Grote order');

-- Gegevens invoegen in BestellingProduct tabel
INSERT INTO BestellingProduct (BestellingID, ProductID, Aantal) VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1),
(3, 5, 3),
(4, 4, 1),
(5, 1, 2),
(5, 2, 3),
(5, 3, 1);

-- Selectiecriteria voor de gevraagde velden

-- 1. Klantnaam (Voornaam, Tussenvoegsel, Achternaam)
-- Aanname: KlantNaam bevat de volledige naam. We gebruiken SUBSTRING_INDEX om deze op te splitsen.
SELECT 
    SUBSTRING_INDEX(KlantNaam, ' ', 1) AS Voornaam,
    CASE 
        WHEN LENGTH(KlantNaam) - LENGTH(REPLACE(KlantNaam, ' ', '')) = 2 
        THEN SUBSTRING_INDEX(SUBSTRING_INDEX(KlantNaam, ' ', -2), ' ', 1)
        ELSE NULL 
    END AS Tussenvoegsel,
    SUBSTRING_INDEX(KlantNaam, ' ', -1) AS Achternaam
FROM Klant;

-- 2. Productnaam
SELECT ProductNaam FROM Product WHERE IsActief = TRUE;

-- 3. AantalProduct
SELECT b.BestellingID, p.ProductNaam, bp.Aantal AS AantalProduct
FROM BestellingProduct bp
JOIN Product p ON bp.ProductID = p.ProductID
JOIN Bestelling b ON bp.BestellingID = b.BestellingID
WHERE b.IsActief = TRUE;

-- 4. Prijs
SELECT ProductNaam, Prijs FROM Product WHERE Prijs > 100 ORDER BY Prijs DESC;

-- 5. Bedrag (totaalbedrag per bestelling)
SELECT 
    b.BestellingID,
    k.KlantNaam,
    SUM(p.Prijs * bp.Aantal) AS Bedrag
FROM 
    Bestelling b
    JOIN BestellingProduct bp ON b.BestellingID = bp.BestellingID
    JOIN Product p ON bp.ProductID = p.ProductID
    JOIN Klant k ON b.KlantID = k.KlantID
WHERE 
    b.IsActief = TRUE
GROUP BY 
    b.BestellingID, k.KlantNaam;