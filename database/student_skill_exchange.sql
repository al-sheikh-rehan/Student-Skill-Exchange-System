CREATE DATABASE IF NOT EXISTS StudentSkillExchange;
USE StudentSkillExchange;

CREATE TABLE IF NOT EXISTS Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    department VARCHAR(100),
    semester INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Skills (
    skill_id INT PRIMARY KEY AUTO_INCREMENT,
    skill_name VARCHAR(100) UNIQUE NOT NULL,
    category VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS StudentSkills (
    student_skill_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    skill_id INT NOT NULL,
    skill_level VARCHAR(30) DEFAULT 'Beginner',
    FOREIGN KEY (student_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id) ON DELETE CASCADE,
    UNIQUE (student_id, skill_id)
);

CREATE TABLE IF NOT EXISTS SkillRequests (
    request_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_id INT NOT NULL,
    receiver_id INT NOT NULL,
    skill_id INT NOT NULL,
    request_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    status ENUM('Pending','Accepted','Rejected') NOT NULL DEFAULT 'Pending',
    message VARCHAR(255),
    FOREIGN KEY (sender_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (receiver_id) REFERENCES Students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id) ON DELETE CASCADE
);

INSERT INTO Students (name,email,phone,department,semester) VALUES
('Rahul Kumar','rahul@gmail.com','9876543210','Computer Science',3),
('Aman Kumar','aman@gmail.com','9876543211','Computer Science',3),
('Priya Singh','priya@gmail.com','9876543212','Information Technology',2),
('Neha Sharma','neha@gmail.com','9876543213','Computer Science',4)
ON DUPLICATE KEY UPDATE name=VALUES(name);

INSERT INTO Skills (skill_name,category) VALUES
('C Programming','Programming'),
('Java','Programming'),
('Python','Programming'),
('Web Development','Technology'),
('Graphic Design','Design'),
('Video Editing','Media')
ON DUPLICATE KEY UPDATE category=VALUES(category);

INSERT IGNORE INTO StudentSkills (student_id,skill_id,skill_level)
SELECT s.student_id, sk.skill_id, v.skill_level
FROM (
    SELECT 'rahul@gmail.com' email, 'C Programming' skill_name, 'Intermediate' skill_level
    UNION ALL SELECT 'rahul@gmail.com','Web Development','Beginner'
    UNION ALL SELECT 'aman@gmail.com','Python','Advanced'
    UNION ALL SELECT 'aman@gmail.com','Web Development','Intermediate'
    UNION ALL SELECT 'priya@gmail.com','Graphic Design','Advanced'
    UNION ALL SELECT 'neha@gmail.com','Video Editing','Intermediate'
) v
JOIN Students s ON s.email=v.email
JOIN Skills sk ON sk.skill_name=v.skill_name;

SELECT s.student_id,s.name,s.email,s.department,s.semester,
       sk.skill_name,ss.skill_level
FROM Students s
LEFT JOIN StudentSkills ss ON s.student_id=ss.student_id
LEFT JOIN Skills sk ON ss.skill_id=sk.skill_id
ORDER BY s.student_id;

SELECT s.student_id,s.name,s.email,s.department,sk.skill_name,ss.skill_level
FROM Students s
JOIN StudentSkills ss ON s.student_id=ss.student_id
JOIN Skills sk ON ss.skill_id=sk.skill_id
WHERE LOWER(sk.skill_name)=LOWER('Web Development')
ORDER BY s.name;

SELECT s.student_id,s.name,s.email,sk.skill_name,ss.skill_level
FROM Students s
JOIN StudentSkills ss ON s.student_id=ss.student_id
JOIN Skills sk ON ss.skill_id=sk.skill_id
WHERE LOWER(sk.skill_name)=LOWER('Python')
ORDER BY s.name;

INSERT INTO SkillRequests(sender_id,receiver_id,skill_id,status,message)
SELECT 1,2,skill_id,'Pending','I want to learn this skill from you.'
FROM Skills WHERE skill_name='Python'
LIMIT 1;

SELECT r.request_id,
       sender.name AS sender,
       receiver.name AS receiver,
       sk.skill_name,
       r.request_date,
       r.status,
       r.message
FROM SkillRequests r
JOIN Students sender ON r.sender_id=sender.student_id
JOIN Students receiver ON r.receiver_id=receiver.student_id
JOIN Skills sk ON r.skill_id=sk.skill_id
ORDER BY r.request_id DESC;