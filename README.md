# 🎓 Student Skill Exchange System

A **DBMS project** designed to help students discover each other's skills and exchange knowledge through skill-based requests.

## 🌐 Live Demo

**[Open Student Skill Exchange System](https://shivshankar28082008-rgb.github.io/Student-Skill-Exchange-System/)**

> The live page is a front-end demonstration using sample data. The actual relational database is provided in the MySQL SQL file.

## 🛠️ Technology

- MySQL 8+
- SQL
- HTML5
- CSS3
- JavaScript

## 🗃️ Database Tables

| Table | Purpose |
|---|---|
| **Students** | Stores student registration and academic details |
| **Skills** | Stores available skills and their categories |
| **StudentSkills** | Connects students with their skills and skill levels |
| **SkillRequests** | Stores skill exchange requests and their status |

## ✨ Features

- 👨‍🎓 Student registration data
- 🧠 Skill management
- 🔗 Student-to-skill mapping
- 🔎 Search students by skill
- 📚 Find students who can teach a particular skill
- 🤝 Create and track skill exchange requests
- 📊 Skill-level information: Beginner, Intermediate and Advanced
- 🔐 Primary keys and foreign keys for relational integrity
- 🗑️ Cascade handling for related records

## 🔄 Skill Exchange Flow

```text
Student A
   │
   │ wants to learn
   ▼
Requested Skill
   │
   │ from
   ▼
Student B
   │
   │ offers another skill
   ▼
Skill Exchange Request
   │
   └── Pending → Accepted → Completed
```

## 🔗 ER Relationship

```text
                    ┌───────────────┐
                    │   Students    │
                    │───────────────│
                    │ PK student_id │
                    └───────┬───────┘
                            │
                       1    │    M
                            ▼
                 ┌──────────────────┐
                 │  StudentSkills   │
                 │──────────────────│
                 │ PK student_skill │
                 │ FK student_id    │
                 │ FK skill_id      │
                 │ skill_level      │
                 └────────┬─────────┘
                          │
                       M  │  1
                          ▼
                    ┌─────────────┐
                    │   Skills    │
                    │─────────────│
                    │ PK skill_id │
                    │ skill_name  │
                    │ category    │
                    └──────┬──────┘
                           │
                       1   │   M
                           ▼
                 ┌──────────────────┐
                 │  SkillRequests   │
                 │──────────────────│
                 │ PK request_id    │
                 │ FK sender_id     │──────► Students
                 │ FK receiver_id   │──────► Students
                 │ FK skill_id      │
                 │ status           │
                 │ message          │
                 └──────────────────┘
```

### Relationship Summary

- **Students 1 : M StudentSkills** — one student can have multiple skills.
- **Skills 1 : M StudentSkills** — one skill can belong to multiple students.
- **Students 1 : M SkillRequests** — a student can send multiple requests.
- **Students 1 : M SkillRequests** — a student can receive multiple requests.
- **Skills 1 : M SkillRequests** — a skill can appear in multiple requests.

## ▶️ How to Run the Database

1. Open **MySQL Workbench**, **phpMyAdmin**, or MySQL Command Line.
2. Open `database/student_skill_exchange.sql`.
3. Execute the complete SQL script.
4. The script creates the database and tables.
5. Sample students and skills are inserted.
6. Run the included SELECT, INSERT and request queries to test the system.

## 📁 Project Structure

```text
Student-Skill-Exchange-System/
│
├── index.html
├── database/
│   └── student_skill_exchange.sql
└── README.md
```

## 🎓 Academic Project

**Project:** Student Skill Exchange System  
**Subject:** Database Management System (DBMS)  
**Database:** MySQL 8+
