DROP Table IF EXISTS Course;

DROP Table if EXISTS Exam;


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
