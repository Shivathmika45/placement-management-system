CREATE DATABASE placement_system;
USE placement_system;
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    department VARCHAR(50),
    cgpa DECIMAL(3,2)
);
CREATE TABLE companies (
    company_id INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    package_lpa DECIMAL(5,2)
);
CREATE TABLE drives (
    drive_id INT PRIMARY KEY AUTO_INCREMENT,
    company_id INT,
    drive_date DATE,
    drive_location VARCHAR(100),
    role VARCHAR(100),
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);
CREATE TABLE applications (
    app_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    drive_id INT,
    status VARCHAR(20),
    applied_date DATE,
    
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (drive_id) REFERENCES drives(drive_id)
);
INSERT INTO students (name, email, phone, department, cgpa) VALUES
('Arjun', 'arjun@gmail.com', '9876543210', 'CSE', 8.5),
('Meena', 'meena@gmail.com', '9123456780', 'IT', 9.1),
('Ravi', 'ravi@gmail.com', '9988776655', 'ECE', 7.8);
INSERT INTO companies (company_name, location, package_lpa) VALUES
('TCS', 'Hyderabad', 3.5),
('Infosys', 'Bangalore', 4.0),
('Wipro', 'Chennai', 3.2);
INSERT INTO drives (company_id, drive_date, drive_location, role) VALUES
(1, '2026-07-01', 'Hyderabad', 'Software Engineer'),
(2, '2026-07-05', 'Bangalore', 'System Engineer'),
(3, '2026-07-10', 'Chennai', 'Developer');
INSERT INTO applications (student_id, drive_id, status, applied_date) VALUES
(1, 1, 'Applied', '2026-06-20'),
(2, 2, 'Selected', '2026-06-21'),
(3, 3, 'Rejected', '2026-06-22');
SELECT * FROM students;
SELECT * FROM companies;
SELECT * FROM drives;
SELECT * FROM applications;
SELECT 
    s.name AS student_name,
    c.company_name,
    d.role,
    a.status
FROM applications a
JOIN students s ON a.student_id = s.student_id
JOIN drives d ON a.drive_id = d.drive_id
JOIN companies c ON d.company_id = c.company_id;
SELECT 
    s.name,
    c.company_name,
    a.status
FROM applications a
JOIN students s ON a.student_id = s.student_id
JOIN drives d ON a.drive_id = d.drive_id
JOIN companies c ON d.company_id = c.company_id
WHERE a.status = 'Selected';
SELECT 
    c.company_name,
    COUNT(a.app_id) AS total_applications
FROM companies c
JOIN drives d ON c.company_id = d.company_id
JOIN applications a ON d.drive_id = a.drive_id
GROUP BY c.company_name;