-- =============================================
-- Student Management Database
-- Created for Educational Purposes
-- =============================================

-- Create the database
CREATE DATABASE StudentManagementDB;
GO

USE StudentManagementDB;
GO

-- =============================================
-- 1. DEPARTMENTS TABLE
-- =============================================
CREATE TABLE Departments (
    DepartmentID int PRIMARY KEY IDENTITY(1,1),
    DepartmentName varchar(100) NOT NULL,
    DepartmentCode varchar(10) NOT NULL UNIQUE,
    DepartmentHead varchar(100),
    Building varchar(50),
    Budget decimal(12,2)
);

-- =============================================
-- 2. INSTRUCTORS TABLE
-- =============================================
CREATE TABLE Instructors (
    InstructorID int PRIMARY KEY IDENTITY(1,1),
    FirstName varchar(50) NOT NULL,
    LastName varchar(50) NOT NULL,
    Email varchar(100) UNIQUE,
    Phone varchar(20),
    DepartmentID int,
    HireDate date,
    Salary decimal(10,2),
    Office varchar(20),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- =============================================
-- 3. STUDENTS TABLE
-- =============================================
CREATE TABLE Students (
    StudentID int PRIMARY KEY IDENTITY(1001,1),
    FirstName varchar(50) NOT NULL,
    LastName varchar(50) NOT NULL,
    Email varchar(100) UNIQUE,
    Phone varchar(20),
    DateOfBirth date,
    Gender char(1) CHECK (Gender IN ('M', 'F', 'O')),
    Address varchar(200),
    City varchar(50),
    State varchar(30),
    ZipCode varchar(10),
    DepartmentID int,
    EnrollmentDate date,
    GPA decimal(3,2) CHECK (GPA >= 0.00 AND GPA <= 4.00),
    Credits int DEFAULT 0,
    Status varchar(20) DEFAULT 'Active' CHECK (Status IN ('Active', 'Inactive', 'Graduated', 'Suspended')),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- =============================================
-- 4. COURSES TABLE
-- =============================================
CREATE TABLE Courses (
    CourseID int PRIMARY KEY IDENTITY(1,1),
    CourseCode varchar(10) NOT NULL UNIQUE,
    CourseName varchar(150) NOT NULL,
    Description text,
    Credits int NOT NULL CHECK (Credits > 0),
    DepartmentID int,
    Prerequisites varchar(200),
    IsActive bit DEFAULT 1,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- =============================================
-- 5. SEMESTERS TABLE
-- =============================================
CREATE TABLE Semesters (
    SemesterID int PRIMARY KEY IDENTITY(1,1),
    SemesterName varchar(50) NOT NULL,
    Year int NOT NULL,
    StartDate date NOT NULL,
    EndDate date NOT NULL,
    IsActive bit DEFAULT 0
);

-- =============================================
-- 6. COURSE SECTIONS TABLE
-- =============================================
CREATE TABLE CourseSections (
    SectionID int PRIMARY KEY IDENTITY(1,1),
    CourseID int,
    SemesterID int,
    InstructorID int,
    SectionNumber varchar(10),
    Schedule varchar(50),
    Room varchar(20),
    MaxCapacity int,
    CurrentEnrollment int DEFAULT 0,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (SemesterID) REFERENCES Semesters(SemesterID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

-- =============================================
-- 7. ENROLLMENTS TABLE
-- =============================================
CREATE TABLE Enrollments (
    EnrollmentID int PRIMARY KEY IDENTITY(1,1),
    StudentID int,
    SectionID int,
    EnrollmentDate date DEFAULT GETDATE(),
    Status varchar(20) DEFAULT 'Enrolled' CHECK (Status IN ('Enrolled', 'Dropped', 'Completed', 'Withdrawn')),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SectionID) REFERENCES CourseSections(SectionID),
    UNIQUE(StudentID, SectionID)
);

-- =============================================
-- 8. GRADES TABLE
-- =============================================
CREATE TABLE Grades (
    GradeID int PRIMARY KEY IDENTITY(1,1),
    EnrollmentID int,
    AssignmentType varchar(50), -- 'Midterm', 'Final', 'Quiz', 'Assignment', 'Project'
    AssignmentName varchar(100),
    Points decimal(5,2),
    MaxPoints decimal(5,2),
    Grade varchar(5),
    GradeDate date DEFAULT GETDATE(),
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);

-- =============================================
-- INSERT SAMPLE DATA
-- =============================================

-- Insert Departments
INSERT INTO Departments (DepartmentName, DepartmentCode, DepartmentHead, Building, Budget) VALUES
('Computer Science', 'CS', 'Dr. Sarah Johnson', 'Tech Building', 2500000.00),
('Mathematics', 'MATH', 'Dr. Robert Chen', 'Science Hall', 1800000.00),
('Business Administration', 'BA', 'Dr. Michael Davis', 'Business Center', 3200000.00),
('English Literature', 'ENG', 'Dr. Emily Williams', 'Humanities Building', 1500000.00),
('Biology', 'BIO', 'Dr. Jennifer Lopez', 'Life Sciences', 2200000.00),
('Psychology', 'PSY', 'Dr. David Miller', 'Social Sciences', 1600000.00);

-- Insert Instructors
INSERT INTO Instructors (FirstName, LastName, Email, Phone, DepartmentID, HireDate, Salary, Office) VALUES
('Sarah', 'Johnson', 'sarah.johnson@university.edu', '555-0101', 1, '2015-08-15', 85000.00, 'TB-201'),
('Robert', 'Chen', 'robert.chen@university.edu', '555-0102', 2, '2012-01-20', 78000.00, 'SH-305'),
('Michael', 'Davis', 'michael.davis@university.edu', '555-0103', 3, '2018-09-01', 92000.00, 'BC-150'),
('Emily', 'Williams', 'emily.williams@university.edu', '555-0104', 4, '2014-03-10', 72000.00, 'HB-220'),
('Jennifer', 'Lopez', 'jennifer.lopez@university.edu', '555-0105', 5, '2016-06-05', 80000.00, 'LS-180'),
('David', 'Miller', 'david.miller@university.edu', '555-0106', 6, '2019-01-15', 75000.00, 'SS-320'),
('Lisa', 'Anderson', 'lisa.anderson@university.edu', '555-0107', 1, '2017-08-20', 70000.00, 'TB-155'),
('James', 'Wilson', 'james.wilson@university.edu', '555-0108', 2, '2013-09-12', 76000.00, 'SH-280'),
('Maria', 'Garcia', 'maria.garcia@university.edu', '555-0109', 3, '2020-02-01', 68000.00, 'BC-175'),
('Thomas', 'Brown', 'thomas.brown@university.edu', '555-0110', 4, '2011-05-30', 82000.00, 'HB-195');

-- Insert Students
INSERT INTO Students (FirstName, LastName, Email, Phone, DateOfBirth, Gender, Address, City, State, ZipCode, DepartmentID, EnrollmentDate, GPA, Credits, Status) VALUES
('Alex', 'Thompson', 'alex.thompson@student.edu', '555-1001', '2002-03-15', 'M', '123 Oak Street', 'Springfield', 'IL', '62701', 1, '2020-08-25', 3.75, 45, 'Active'),
('Emma', 'Rodriguez', 'emma.rodriguez@student.edu', '555-1002', '2001-11-22', 'F', '456 Pine Avenue', 'Springfield', 'IL', '62702', 2, '2019-08-20', 3.92, 78, 'Active'),
('Jordan', 'Kim', 'jordan.kim@student.edu', '555-1003', '2003-07-08', 'O', '789 Maple Drive', 'Riverside', 'IL', '62703', 1, '2021-08-30', 3.45, 32, 'Active'),
('Sophia', 'Patel', 'sophia.patel@student.edu', '555-1004', '2002-01-12', 'F', '321 Elm Street', 'Madison', 'IL', '62704', 3, '2020-08-25', 3.88, 52, 'Active'),
('Marcus', 'Washington', 'marcus.washington@student.edu', '555-1005', '2001-09-30', 'M', '654 Cedar Lane', 'Springfield', 'IL', '62705', 5, '2019-08-20', 3.65, 85, 'Active'),
('Isabella', 'Taylor', 'isabella.taylor@student.edu', '555-1006', '2003-05-18', 'F', '987 Birch Road', 'Greenfield', 'IL', '62706', 4, '2021-08-30', 3.70, 28, 'Active'),
('Cameron', 'Lee', 'cameron.lee@student.edu', '555-1007', '2002-12-03', 'M', '147 Willow Way', 'Springfield', 'IL', '62707', 6, '2020-08-25', 3.25, 48, 'Active'),
('Zoe', 'Martinez', 'zoe.martinez@student.edu', '555-1008', '2001-06-25', 'F', '258 Ash Boulevard', 'Riverside', 'IL', '62708', 1, '2019-08-20', 3.95, 92, 'Active'),
('Ethan', 'Clark', 'ethan.clark@student.edu', '555-1009', '2003-02-14', 'M', '369 Poplar Street', 'Madison', 'IL', '62709', 2, '2021-08-30', 3.15, 35, 'Active'),
('Ava', 'White', 'ava.white@student.edu', '555-1010', '2002-10-07', 'F', '741 Hickory Drive', 'Springfield', 'IL', '62710', 3, '2020-08-25', 3.82, 58, 'Active'),
('Noah', 'Jackson', 'noah.jackson@student.edu', '555-1011', '2001-04-20', 'M', '852 Walnut Avenue', 'Greenfield', 'IL', '62711', 4, '2019-08-20', 3.40, 75, 'Active'),
('Mia', 'Harris', 'mia.harris@student.edu', '555-1012', '2003-08-11', 'F', '963 Cherry Lane', 'Springfield', 'IL', '62712', 5, '2021-08-30', 3.60, 25, 'Active'),
('Liam', 'Moore', 'liam.moore@student.edu', '555-1013', '2000-12-28', 'M', '159 Spruce Road', 'Riverside', 'IL', '62713', 6, '2018-08-22', 3.55, 105, 'Active'),
('Charlotte', 'Anderson', 'charlotte.anderson@student.edu', '555-1014', '2002-07-16', 'F', '357 Fir Street', 'Madison', 'IL', '62714', 1, '2020-08-25', 3.78, 42, 'Active'),
('Oliver', 'Thomas', 'oliver.thomas@student.edu', '555-1015', '2001-03-09', 'M', '486 Pine Court', 'Springfield', 'IL', '62715', 2, '2019-08-20', 3.85, 68, 'Active');

-- Insert Courses
INSERT INTO Courses (CourseCode, CourseName, Description, Credits, DepartmentID, Prerequisites) VALUES
('CS101', 'Introduction to Programming', 'Basic programming concepts using Python', 3, 1, NULL),
('CS201', 'Data Structures and Algorithms', 'Fundamental data structures and algorithms', 4, 1, 'CS101'),
('CS301', 'Database Systems', 'Design and implementation of database systems', 3, 1, 'CS201'),
('CS401', 'Software Engineering', 'Software development methodologies and practices', 4, 1, 'CS301'),
('MATH101', 'College Algebra', 'Fundamental algebraic concepts and operations', 3, 2, NULL),
('MATH201', 'Calculus I', 'Differential calculus and applications', 4, 2, 'MATH101'),
('MATH301', 'Statistics', 'Statistical analysis and probability theory', 3, 2, 'MATH201'),
('BA101', 'Introduction to Business', 'Overview of business principles and practices', 3, 3, NULL),
('BA201', 'Accounting Principles', 'Fundamental accounting concepts and practices', 3, 3, NULL),
('BA301', 'Marketing Management', 'Marketing strategies and consumer behavior', 3, 3, 'BA101'),
('ENG101', 'English Composition', 'Writing skills and literary analysis', 3, 4, NULL),
('ENG201', 'American Literature', 'Survey of American literary works', 3, 4, 'ENG101'),
('BIO101', 'General Biology', 'Introduction to biological sciences', 4, 5, NULL),
('BIO201', 'Genetics', 'Principles of heredity and molecular genetics', 4, 5, 'BIO101'),
('PSY101', 'Introduction to Psychology', 'Basic psychological principles and theories', 3, 6, NULL);

-- Insert Semesters
INSERT INTO Semesters (SemesterName, Year, StartDate, EndDate, IsActive) VALUES
('Fall', 2023, '2023-08-28', '2023-12-15', 0),
('Spring', 2024, '2024-01-16', '2024-05-10', 0),
('Fall', 2024, '2024-08-26', '2024-12-13', 1),
('Spring', 2025, '2025-01-14', '2025-05-09', 0);

-- Insert Course Sections
INSERT INTO CourseSections (CourseID, SemesterID, InstructorID, SectionNumber, Schedule, Room, MaxCapacity, CurrentEnrollment) VALUES
(1, 3, 1, '001', 'MWF 9:00-9:50', 'TB-101', 30, 25),
(1, 3, 7, '002', 'TR 11:00-12:15', 'TB-102', 30, 28),
(2, 3, 1, '001', 'MWF 10:00-10:50', 'TB-201', 25, 22),
(3, 3, 7, '001', 'TR 2:00-3:15', 'TB-301', 25, 20),
(4, 3, 1, '001', 'MWF 1:00-1:50', 'TB-401', 20, 18),
(5, 3, 2, '001', 'MWF 8:00-8:50', 'SH-101', 35, 32),
(6, 3, 8, '001', 'TR 9:30-10:45', 'SH-201', 30, 28),
(7, 3, 2, '001', 'MWF 11:00-11:50', 'SH-301', 30, 25),
(8, 3, 3, '001', 'TR 8:00-9:15', 'BC-101', 40, 35),
(9, 3, 9, '001', 'MWF 2:00-2:50', 'BC-201', 35, 30),
(10, 3, 3, '001', 'TR 3:30-4:45', 'BC-301', 30, 25),
(11, 3, 4, '001', 'MWF 10:00-10:50', 'HB-101', 30, 27),
(12, 3, 10, '001', 'TR 1:00-2:15', 'HB-201', 25, 22),
(13, 3, 5, '001', 'MTWRF 9:00-9:50', 'LS-101', 28, 24),
(14, 3, 5, '001', 'TR 10:00-11:15', 'LS-201', 25, 20),
(15, 3, 6, '001', 'MWF 3:00-3:50', 'SS-101', 35, 30);

-- Insert Enrollments
INSERT INTO Enrollments (StudentID, SectionID, EnrollmentDate, Status) VALUES
-- Alex Thompson (Student 1001) - CS Major
(1001, 1, '2024-08-20', 'Enrolled'),  -- CS101
(1001, 3, '2024-08-20', 'Enrolled'),  -- CS201
(1001, 5, '2024-08-21', 'Enrolled'),  -- MATH201
(1001, 11, '2024-08-21', 'Enrolled'), -- ENG101

-- Emma Rodriguez (Student 1002) - Math Major
(1002, 6, '2024-08-19', 'Enrolled'),  -- MATH101
(1002, 7, '2024-08-19', 'Enrolled'),  -- Calculus I
(1002, 8, '2024-08-20', 'Enrolled'),  -- Statistics
(1002, 11, '2024-08-20', 'Enrolled'), -- ENG101

-- Jordan Kim (Student 1003) - CS Major
(1003, 2, '2024-08-22', 'Enrolled'),  -- CS101
(1003, 6, '2024-08-22', 'Enrolled'),  -- MATH101
(1003, 15, '2024-08-23', 'Enrolled'), -- PSY101

-- Continue with more enrollments...
(1004, 9, '2024-08-21', 'Enrolled'),  -- BA101
(1004, 10, '2024-08-21', 'Enrolled'), -- Accounting
(1004, 11, '2024-08-21', 'Enrolled'), -- ENG101

(1005, 13, '2024-08-20', 'Enrolled'), -- BIO101
(1005, 14, '2024-08-20', 'Enrolled'), -- Genetics
(1005, 6, '2024-08-20', 'Enrolled'),  -- MATH101

(1006, 11, '2024-08-23', 'Enrolled'), -- ENG101
(1006, 12, '2024-08-23', 'Enrolled'), -- American Lit
(1006, 15, '2024-08-23', 'Enrolled'), -- PSY101

(1007, 15, '2024-08-22', 'Enrolled'), -- PSY101
(1007, 11, '2024-08-22', 'Enrolled'), -- ENG101
(1007, 6, '2024-08-22', 'Enrolled'),  -- MATH101

(1008, 1, '2024-08-19', 'Enrolled'),  -- CS101
(1008, 3, '2024-08-19', 'Enrolled'),  -- CS201
(1008, 4, '2024-08-19', 'Enrolled'),  -- Database Systems

(1009, 6, '2024-08-24', 'Enrolled'),  -- MATH101
(1009, 7, '2024-08-24', 'Enrolled'),  -- Calculus I
(1009, 15, '2024-08-24', 'Enrolled'), -- PSY101

(1010, 9, '2024-08-21', 'Enrolled'),  -- BA101
(1010, 11, '2024-08-21', 'Enrolled'); -- ENG101

-- Insert Sample Grades
-- Instead of hardcoded EnrollmentIDs, use subqueries to find the correct IDs
INSERT INTO Grades (EnrollmentID, AssignmentType, AssignmentName, Points, MaxPoints, Grade, GradeDate) VALUES

-- Grades for Alex Thompson's CS101 course
((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1001 AND SectionID = 1), 
 'Quiz', 'Python Basics Quiz', 18.5, 20, 'A-', '2024-09-15'),

((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1001 AND SectionID = 1), 
 'Assignment', 'First Programming Project', 92, 100, 'A-', '2024-10-01'),

((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1001 AND SectionID = 1), 
 'Midterm', 'Midterm Exam', 85, 100, 'B+', '2024-10-15'),

-- Grades for Alex Thompson's CS201 course
((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1001 AND SectionID = 3), 
 'Quiz', 'Data Structures Quiz 1', 16, 20, 'B', '2024-09-20'),

((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1001 AND SectionID = 3), 
 'Assignment', 'Binary Tree Implementation', 88, 100, 'B+', '2024-10-05'),

-- Grades for Emma Rodriguez's MATH101 course  
((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1002 AND SectionID = 6), 
 'Quiz', 'Algebra Review', 19, 20, 'A-', '2024-09-10'),

((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1002 AND SectionID = 6), 
 'Assignment', 'Problem Set 1', 95, 100, 'A', '2024-09-25'),

((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1002 AND SectionID = 6), 
 'Midterm', 'Midterm Exam', 92, 100, 'A-', '2024-10-12'),

-- Grades for Emma Rodriguez's Calculus I course
((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1002 AND SectionID = 7), 
 'Quiz', 'Limits and Derivatives', 17, 20, 'B+', '2024-09-18'),

((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1002 AND SectionID = 7), 
 'Assignment', 'Calculus Problem Set', 90, 100, 'A-', '2024-10-02'),

-- Additional grades
((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1002 AND SectionID = 8), 
 'Quiz', 'Probability Quiz', 15, 20, 'B-', '2024-09-22'),

((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1004 AND SectionID = 9), 
 'Assignment', 'Business Plan Draft', 85, 100, 'B', '2024-10-01'),

((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1005 AND SectionID = 13), 
 'Quiz', 'Cell Biology Quiz', 18, 20, 'A-', '2024-09-14'),

((SELECT EnrollmentID FROM Enrollments WHERE StudentID = 1006 AND SectionID = 11), 
 'Assignment', 'Essay Assignment', 87, 100, 'B+', '2024-09-28');

-- =============================================
-- USEFUL VIEWS FOR TEACHING
-- =============================================

-- View: Student Transcript
CREATE VIEW StudentTranscript AS
SELECT 
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    c.CourseCode,
    c.CourseName,
    c.Credits,
    sem.SemesterName + ' ' + CAST(sem.Year AS varchar) AS Semester,
    i.FirstName + ' ' + i.LastName AS Instructor,
    AVG(g.Points / g.MaxPoints * 100) AS FinalGrade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN CourseSections cs ON e.SectionID = cs.SectionID
JOIN Courses c ON cs.CourseID = c.CourseID
JOIN Semesters sem ON cs.SemesterID = sem.SemesterID
JOIN Instructors i ON cs.InstructorID = i.InstructorID
LEFT JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
GROUP BY s.StudentID, s.FirstName, s.LastName, c.CourseCode, c.CourseName, 
         c.Credits, sem.SemesterName, sem.Year, i.FirstName, i.LastName;

-- View: Department Statistics
CREATE VIEW DepartmentStats AS
SELECT 
    d.DepartmentName,
    COUNT(DISTINCT s.StudentID) AS TotalStudents,
    COUNT(DISTINCT i.InstructorID) AS TotalInstructors,
    COUNT(DISTINCT c.CourseID) AS TotalCourses,
    AVG(s.GPA) AS AverageDepartmentGPA
FROM Departments d
LEFT JOIN Students s ON d.DepartmentID = s.DepartmentID
LEFT JOIN Instructors i ON d.DepartmentID = i.DepartmentID
LEFT JOIN Courses c ON d.DepartmentID = c.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName;

-- =============================================
-- SAMPLE QUERIES FOR TEACHING
-- =============================================

/*
-- 1. Find all students in Computer Science department
SELECT s.FirstName, s.LastName, s.Email, s.GPA
FROM Students s
JOIN Departments d ON s.DepartmentID = d.DepartmentID
WHERE d.DepartmentCode = 'CS'
ORDER BY s.GPA DESC;

-- 2. Get course enrollment statistics
SELECT 
    c.CourseCode,
    c.CourseName,
    cs.SectionNumber,
    cs.MaxCapacity,
    cs.CurrentEnrollment,
    (cs.CurrentEnrollment * 100.0 / cs.MaxCapacity) AS EnrollmentPercentage
FROM Courses c
JOIN CourseSections cs ON c.CourseID = cs.CourseID
ORDER BY EnrollmentPercentage DESC;

-- 3. Find students with GPA above 3.5
SELECT 
    FirstName + ' ' + LastName AS StudentName,
    Email,
    GPA,
    Credits,
    Status
FROM Students
WHERE GPA > 3.5
ORDER BY GPA DESC;

-- 4. Get instructor workload
SELECT 
    i.FirstName + ' ' + i.LastName AS InstructorName,
    d.DepartmentName,
    COUNT(cs.SectionID) AS SectionsTeaching,
    SUM(cs.CurrentEnrollment) AS TotalStudents
FROM Instructors i
LEFT JOIN CourseSections cs ON i.InstructorID = cs.InstructorID
JOIN Departments d ON i.DepartmentID = d.DepartmentID
GROUP BY i.InstructorID, i.FirstName, i.LastName, d.DepartmentName
ORDER BY TotalStudents DESC;

-- 5. Student transcript query
SELECT * FROM StudentTranscript
WHERE StudentName LIKE 'Alex%'
ORDER BY Semester;
*/

-- Get Alex's transcript
-- SELECT * FROM StudentTranscript 
-- WHERE StudentName LIKE 'Alex%';

-- -- Get department statistics
-- SELECT * FROM DepartmentStats 
-- ORDER BY TotalStudents DESC;

-- -- Filter view results
-- SELECT DepartmentName, TotalStudents 
-- FROM DepartmentStats 
-- WHERE TotalStudents > 2;
