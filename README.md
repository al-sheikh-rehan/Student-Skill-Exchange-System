# Student Skill Exchange System

A simple MySQL DBMS project for exchanging skills among students.

## Technology
- MySQL 8+
- SQL

## Tables
- Students
- Skills
- StudentSkills
- SkillRequests

## Features
- Student registration data
- Skill management
- Student-to-skill mapping
- Search students by skill
- Find students who can teach a skill
- Send and track skill exchange requests
- Relational database with primary and foreign keys

## How to Run
1. Open MySQL Workbench, phpMyAdmin, or MySQL command line.
2. Open `database/student_skill_exchange.sql`.
3. Run the complete script.
4. The script creates the database, tables, sample data, and demonstration queries.

## ER Relationship
Students 1---M StudentSkills M---1 Skills
Students 1---M SkillRequests (sender)
Students 1---M SkillRequests (receiver)
Skills 1---M SkillRequests
