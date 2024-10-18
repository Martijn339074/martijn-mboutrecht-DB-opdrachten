DROP DATABASE IF EXISTS BoekingenSys;

CREATE DATABASE BoekingenSys;

CREATE TABLE Passagiers (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PassagierNaam VARCHAR(255) NOT NULL,
    PassagierAdres VARCHAR(255) NOT NULL,
    IsActief BIT DEFAULT 1,
    Opmerking TEXT NULL,
    AangemaaktDatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    GewijzigdDatum DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Vluchten (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    VluchtNr VARCHAR(10) NOT NULL,
    Bestemming VARCHAR(255) NOT NULL,
    VertrekDatum DATE NOT NULL,
    MaatschappijNaam VARCHAR(255) NOT NULL,
    Vliegveld VARCHAR(255) NOT NULL,
    IsActief BIT DEFAULT 1,
    Opmerking TEXT NULL,
    AangemaaktDatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    GewijzigdDatum DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Tickets (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    PassagierId INT UNSIGNED NOT NULL,
    VluchtId INT UNSIGNED NOT NULL,
    StoelNr VARCHAR(10) NOT NULL,
    TicketPrijs DECIMAL(10, 2) NOT NULL,
    IsActief BIT DEFAULT 1,
    Opmerking TEXT NULL,
    AangemaaktDatum DATETIME DEFAULT CURRENT_TIMESTAMP,
    GewijzigdDatum DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (PassagierId) REFERENCES Passagiers(id),
    FOREIGN KEY (VluchtId) REFERENCES Vluchten(id)
);

-- Invoegen in de tabel Passagiers
INSERT INTO Passagiers (PassagierNaam, PassagierAdres, IsActief, Opmerking, AangemaaktDatum, GewijzigdDatum)
VALUES 
    ('Jan de Vries', 'Naxosdreef 177, 3564 JG Utrecht', 1, NULL, NOW(), NOW()),
    ('Anne Jansen', 'Sesamstraat 1, 2012 ES Amsterdam', 1, NULL, NOW(), NOW()),
    ('Kees van Dam', 'Hoofdstraat 45, 1234 AB Den Haag', 1, NULL, NOW(), NOW()),
    ('Marie Peters', 'Kerkplein 33, 6789 CD Rotterdam', 1, NULL, NOW(), NOW()),
    ('Tom Holland', 'Bakkerstraat 9, 5432 EF Zwolle', 1, NULL, NOW(), NOW());

-- Invoegen in de tabel Vluchten
INSERT INTO Vluchten (VluchtNr, Bestemming, VertrekDatum, MaatschappijNaam, Vliegveld, IsActief, Opmerking, AangemaaktDatum, GewijzigdDatum)
VALUES 
    ('KL123', 'Amsterdam', '2024-11-01', 'KLM', 'Schiphol', 1, NULL, NOW(), NOW()),
    ('AF456', 'Parijs', '2024-11-02', 'Air France', 'Charles de Gaulle', 1, NULL, NOW(), NOW()),
    ('FR245', 'Malaga', '2024-11-15', 'Ryanair', 'Malaga', 1, NULL, NOW(), NOW()),
    ('EJU7887', 'Mallorca', '2024-12-15', 'EasyJet', 'Palma', 1, NULL, NOW(), NOW()),
    ('LH990', 'Berlijn', '2024-11-20', 'Lufthansa', 'Tegel', 1, NULL, NOW(), NOW());

-- Invoegen in de tabel Tickets
INSERT INTO Tickets (PassagierId, VluchtId, StoelNr, TicketPrijs, IsActief, Opmerking, AangemaaktDatum, GewijzigdDatum)
VALUES 
    (1, 1, '12A', 200, 1, NULL, NOW(), NOW()),
    (2, 2, '14B', 150, 1, NULL, NOW(), NOW()),
    (3, 3, '27D', 300, 1, NULL, NOW(), NOW()),
    (4, 4, '20B', 250, 1, NULL, NOW(), NOW()),
    (5, 5, '32C', 175, 1, NULL, NOW(), NOW());

SELECT * FROM Passagiers
WHERE PassagierNaam LIKE '%de Vries';

SELECT * FROM Passagiers
WHERE PassagierAdres LIKE 'Sesamstraat%';

SELECT * FROM Passagiers
WHERE PassagierAdres LIKE '%3564 JG%';

SELECT * FROM Passagiers
WHERE PassagierAdres LIKE '%Utrecht%';

SELECT * FROM Tickets t
JOIN Vluchten v ON t.VluchtId = v.id
WHERE v.VluchtNr = 'KL123';

SELECT * FROM Tickets
WHERE StoelNr = '12A';

SELECT * FROM Tickets
WHERE TicketPrijs > 200;
