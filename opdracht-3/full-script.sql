DROP DATABASE IF EXISTS school;

CREATE DATABASE school;

USE school;

CREATE TABLE Student (
    id INT(11) AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    infix VARCHAR(10) DEFAULT NULL,
    lastname  VARCHAR(50) NOT NULL,
    number INT(8) NOT NULL,
    mobile VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    isActive BIT NOT NULL DEFAULT 1,
    comment VARCHAR(250) DEFAULT NULL,
    createdDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    changedDate DATE DEFAULT NULL
);

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

CREATE TABLE Course (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    code VARCHAR(10) NOT NULL UNIQUE,
    isActive BIT NOT NULL DEFAULT 1,
    remark TEXT,
    createdDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    changedDate DATE DEFAULT NULL
);

CREATE TABLE Exam (
    id INT AUTO_INCREMENT PRIMARY KEY,
    studentId INT NOT NULL,
    courseId INT NOT NULL,
    examDate DATE NOT NULL,
    grade DECIMAL(2,1) NOT NULL,
    isActive BIT NOT NULL DEFAULT 1,
    remark TEXT,
    createdDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    changedDate DATE DEFAULT NULL,
    FOREIGN KEY (studentId) REFERENCES Student(id),
    FOREIGN KEY (courseId) REFERENCES Course(id)
);

INSERT INTO Student (firstname, infix, lastname, number, mobile, email, isActive, comment)
VALUES 
('John', NULL, 'Doe', 12345678, '+1234567890', 'john.doe@email.com', 1, 'Excellent student'),
('Jane', 'van', 'Smith', 23456789, '+2345678901', 'jane.smith@email.com', 1, NULL),
('Mike', 'de', 'Johnson', 34567890, '+3456789012', 'mike.johnson@email.com', 1, 'Needs improvement in math'),
('Emily', NULL, 'Brown', 45678901, '+4567890123', 'emily.brown@email.com', 0, 'On temporary leave'),
('David', 'von', 'Wilson', 56789012, '+5678901234', 'david.wilson@email.com', 1, 'Transfer student');

INSERT INTO Address (studentId, streetName, houseNumber, addition, postalCode, city, remark)
VALUES 
(1, 'Main Street', '10', NULL, '1234 AB', 'Amsterdam', 'Main address'),
(2, 'Church Way', '25', 'A', '5678 CD', 'Rotterdam', NULL),
(3, 'Village Lane', '5', NULL, '9012 EF', 'Utrecht', 'Temporary address'),
(4, 'Station Square', '100', 'B', '3456 GH', 'The Hague', NULL),
(5, 'Market Street', '15', NULL, '7890 IJ', 'Eindhoven', 'New address');

INSERT INTO Course (name, code, remark) VALUES 
('Mathematics', 'MATH101', 'Basic math for first-year students'),
('Dutch', 'DUT201', 'Advanced Dutch language'),
('English', 'ENG301', 'Business English'),
('History', 'HIST101', 'World history'),
('Biology', 'BIO201', 'Human anatomy');

INSERT INTO Exam (studentId, courseId, examDate, grade, remark) VALUES 
(1, 1, '2024-03-15', 7.5, 'Good result'),
(2, 2, '2024-03-16', 8.0, 'Excellent performance'),
(3, 3, '2024-03-17', 6.5, 'Sufficient, but room for improvement'),
(4, 4, '2024-03-18', 9.0, 'Exceptionally good'),
(5, 5, '2024-03-19', 7.0, 'Solid performance');

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

SELECT 
    CONCAT(s.firstname, ' ', IFNULL(CONCAT(s.infix, ' '), ''), s.lastname) AS FullName,
    s.number AS Number,
    CONCAT(a.streetName, ' ', a.houseNumber, IFNULL(CONCAT(' ', a.addition), '')) AS Address,
    a.postalCode AS PostalCode,
    a.city AS City,
    v.name AS CourseName,
    v.code AS CourseCode,
    t.examDate,
    t.grade
FROM 
    student s
JOIN 
    Address a ON s.id = a.studentId
JOIN 
    Exam t ON s.id = t.studentId
JOIN 
    Course v ON t.courseId = v.id
WHERE 
    s.isActive = 1 AND a.isActive = 1 AND t.isActive = 1 AND v.isActive = 1
ORDER BY 
    s.lastname, v.name, t.examDate;
