-- Student Skill Exchange System
-- MySQL / MariaDB compatible

CREATE DATABASE IF NOT EXISTS student_skill_exchange;
USE student_skill_exchange;

DROP TABLE IF EXISTS SkillRequests;
DROP TABLE IF EXISTS StudentSkills;
DROP TABLE IF EXISTS Skills;
DROP TABLE IF EXISTS Students;

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    course VARCHAR(100) NOT NULL,
    semester INT NOT NULL,
    phone VARCHAR(20)
);

CREATE TABLE Skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(100) UNIQUE NOT NULL,
    category VARCHAR(60) NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE StudentSkills (
    student_skill_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    skill_id INT NOT NULL,
    skill_level ENUM('Beginner','Intermediate','Advanced') DEFAULT 'Beginner',
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id) ON DELETE CASCADE,
    UNIQUE (student_id, skill_id)
);

CREATE TABLE SkillRequests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    requester_id INT NOT NULL,
    provider_id INT NOT NULL,
    requested_skill_id INT NOT NULL,
    offered_skill_id INT,
    request_message VARCHAR(255),
    request_status ENUM('Pending','Accepted','Rejected','Completed') DEFAULT 'Pending',
    requested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (requester_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (provider_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (requested_skill_id) REFERENCES Skills(skill_id) ON DELETE CASCADE,
    FOREIGN KEY (offered_skill_id) REFERENCES Skills(skill_id) ON DELETE SET NULL
);

-- Sample Students
INSERT INTO Students (student_name, email, course, semester, phone) VALUES
('Aarav Kumar','aarav@example.com','Diploma in Computer Science',4,'9876500001'),
('Priya Sharma','priya@example.com','B.Tech CSE',3,'9876500002'),
('Rohit Verma','rohit@example.com','BCA',2,'9876500003'),
('Neha Singh','neha@example.com','B.Tech IT',5,'9876500004');

-- Sample Skills
INSERT INTO Skills (skill_name, category, description) VALUES
('C Programming','Programming','Procedural programming and problem solving'),
('MySQL','Database','Database design and SQL queries'),
('Web Development','Development','HTML, CSS and JavaScript'),
('Graphic Design','Design','Posters, UI graphics and branding'),
('Video Editing','Media','Editing and motion-based video production'),
('Python','Programming','Python programming and automation');

-- Student skills
INSERT INTO StudentSkills (student_id, skill_id, skill_level) VALUES
(1,1,'Advanced'),
(1,2,'Intermediate'),
(2,3,'Advanced'),
(2,4,'Intermediate'),
(3,5,'Advanced'),
(3,6,'Intermediate'),
(4,2,'Advanced'),
(4,3,'Intermediate');

-- Sample exchange requests
INSERT INTO SkillRequests
(requester_id, provider_id, requested_skill_id, offered_skill_id, request_message, request_status)
VALUES
(1,2,3,1,'I can teach C in exchange for Web Development guidance.','Pending'),
(2,1,2,3,'I want to learn MySQL and can help with Web Development.','Accepted'),
(3,4,2,5,'I need help with MySQL and can offer Video Editing.','Completed');

-- 1. View all students
SELECT * FROM Students;

-- 2. View all skills
SELECT * FROM Skills;

-- 3. Find students who know a particular skill
SELECT s.student_id, s.student_name, s.course, ss.skill_level
FROM Students s
JOIN StudentSkills ss ON s.student_id = ss.student_id
JOIN Skills sk ON ss.skill_id = sk.skill_id
WHERE sk.skill_name = 'MySQL';

-- 4. Find students offering advanced skills
SELECT s.student_name, sk.skill_name, ss.skill_level
FROM Students s
JOIN StudentSkills ss ON s.student_id = ss.student_id
JOIN Skills sk ON ss.skill_id = sk.skill_id
WHERE ss.skill_level = 'Advanced';

-- 5. Show exchange requests with student and skill details
SELECT
    sr.request_id,
    requester.student_name AS requester,
    provider.student_name AS provider,
    requested.skill_name AS requested_skill,
    offered.skill_name AS offered_skill,
    sr.request_status
FROM SkillRequests sr
JOIN Students requester ON sr.requester_id = requester.student_id
JOIN Students provider ON sr.provider_id = provider.student_id
JOIN Skills requested ON sr.requested_skill_id = requested.skill_id
LEFT JOIN Skills offered ON sr.offered_skill_id = offered.skill_id;

-- 6. Pending requests
SELECT * FROM SkillRequests
WHERE request_status = 'Pending';

-- 7. Update a request status
UPDATE SkillRequests
SET request_status = 'Accepted'
WHERE request_id = 1;

-- 8. Add a new student
INSERT INTO Students (student_name, email, course, semester, phone)
VALUES ('Simran Das','simran@example.com','BCA',1,'9876500005');

-- 9. Delete a student
-- DELETE FROM Students WHERE student_id = 5;

-- 10. Count students per skill
SELECT sk.skill_name, COUNT(ss.student_id) AS student_count
FROM Skills sk
LEFT JOIN StudentSkills ss ON sk.skill_id = ss.skill_id
GROUP BY sk.skill_id, sk.skill_name
ORDER BY student_count DESC;
