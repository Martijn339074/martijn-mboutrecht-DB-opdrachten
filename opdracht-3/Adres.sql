DROP TABLE if EXISTS Address;

CREATE TABLE Address (
    id INT AUTO_INCREMENT PRIMARY KEY,
    studentId INT NOT NULL,
    streetName VARCHAR(100) NOT NULL,
    houseNumber VARCHAR(10) NOT NULL,
    addition VARCHAR(10),
    postalCode VARCHAR(7) NOT NULL,
    city VARCHAR(50) NOT NULL,
    isActive BIT NOT NULL DEFAULT 1,
    remark TEXT,
    createdDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    changedDate DATE DEFAULT NULL,
    FOREIGN KEY (studentId) REFERENCES Student(id)
);

INSERT INTO Address (studentId, streetName, houseNumber, addition, postalCode, city, remark)
VALUES 
(1, 'Main Street', '10', NULL, '1234 AB', 'Amsterdam', 'Main address'),
(2, 'Church Way', '25', 'A', '5678 CD', 'Rotterdam', NULL),
(3, 'Village Lane', '5', NULL, '9012 EF', 'Utrecht', 'Temporary address'),
(4, 'Station Square', '100', 'B', '3456 GH', 'The Hague', NULL),
(5, 'Market Street', '15', NULL, '7890 IJ', 'Eindhoven', 'New address');

SELECT 
    CONCAT(s.firstname, ' ', IFNULL(CONCAT(s.infix, ' '), ''), s.lastname) AS FullName,
    s.number AS Number,
    s.mobile AS Mobile,
    s.email AS Email,
    CONCAT(a.streetName, ' ', a.houseNumber, IFNULL(CONCAT(' ', a.addition), '')) AS Address,
    a.postalCode AS PostalCode,
    a.city AS City
FROM 
    student s
JOIN 
    Address a ON s.id = a.studentId
WHERE 
    a.isActive = 1;