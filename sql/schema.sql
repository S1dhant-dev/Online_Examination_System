-- ==============================================================
-- Online Examination System Database Schema & Data Seeding
-- Designed for Chandigarh University (University Institute of Computing)
-- ==============================================================

CREATE DATABASE IF NOT EXISTS online_exam_db;
USE online_exam_db;

-- 1. Users / Students Table
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    uid_no VARCHAR(30) UNIQUE NOT NULL,
    class_section VARCHAR(50) NOT NULL,
    role ENUM('STUDENT', 'ADMIN') DEFAULT 'STUDENT',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Exams Table
CREATE TABLE IF NOT EXISTS exams (
    exam_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    duration_minutes INT NOT NULL DEFAULT 15,
    total_marks INT NOT NULL DEFAULT 20,
    passing_marks INT NOT NULL DEFAULT 8
);

-- 3. Questions Table
CREATE TABLE IF NOT EXISTS questions (
    question_id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT NOT NULL,
    question_text TEXT NOT NULL,
    option_a VARCHAR(255) NOT NULL,
    option_b VARCHAR(255) NOT NULL,
    option_c VARCHAR(255) NOT NULL,
    option_d VARCHAR(255) NOT NULL,
    correct_option CHAR(1) NOT NULL, -- 'A', 'B', 'C', 'D'
    marks INT DEFAULT 2,
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id) ON DELETE CASCADE
);

-- 4. Exam Results & Score History Table
CREATE TABLE IF NOT EXISTS exam_results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    exam_id INT NOT NULL,
    total_questions INT NOT NULL,
    attempted INT NOT NULL,
    correct_answers INT NOT NULL,
    obtained_marks INT NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    status ENUM('PASSED', 'FAILED') NOT NULL,
    attempted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id) ON DELETE CASCADE
);

-- Seed Initial Users (Default Student & Admin)
INSERT INTO users (user_id, username, password, full_name, uid_no, class_section, role) VALUES
(1, 'student', 'pass123', 'Sidhant', '21MCI10087', 'MCA (AI & ML) - Sec 4', 'STUDENT'),
(2, 'admin', 'admin123', 'Prof. Shivam Ojha', 'FAC10042', 'Faculty of Computing', 'ADMIN')
ON DUPLICATE KEY UPDATE username=username;

-- Seed Exam
INSERT INTO exams (exam_id, title, subject, duration_minutes, total_marks, passing_marks) VALUES
(1, 'NIMCET Mock Test - Computer Awareness & Advanced Java', 'Advanced Java Programming', 15, 20, 8)
ON DUPLICATE KEY UPDATE title=title;

-- Seed 10 Real-world Computer Science / Java Questions
DELETE FROM questions WHERE exam_id = 1;
INSERT INTO questions (exam_id, question_text, option_a, option_b, option_c, option_d, correct_option, marks) VALUES
(1, 'Which of the following data structures operates on a Last-In, First-Out (LIFO) basis?', 'Queue', 'Stack', 'Array', 'Linked List', 'B', 2),
(1, 'Which component in the Java runtime environment is responsible for dynamic bytecode execution?', 'JDK', 'JVM', 'JRE', 'JDB', 'B', 2),
(1, 'What is the default initial capacity of an ArrayList in Java Collections framework?', '10', '16', '0', '8', 'A', 2),
(1, 'Which keyword is used by a class to inherit member contracts from an interface in Java?', 'extends', 'inherits', 'implements', 'import', 'C', 2),
(1, 'Which of these exceptions is thrown when an array is accessed beyond its indexed bound?', 'NullPointerException', 'ArrayIndexOutOfBoundsException', 'ClassCastException', 'IllegalArgumentException', 'B', 2),
(1, 'What is the time complexity of searching an element in a balanced Binary Search Tree (AVL)?', 'O(1)', 'O(n)', 'O(log n)', 'O(n log n)', 'C', 2),
(1, 'Which HTTP method is defined as idempotent and used to replace an entire resource state?', 'POST', 'PUT', 'PATCH', 'CONNECT', 'B', 2),
(1, 'Which SQL keyword is utilized to remove duplicate rows from the projected result set?', 'DISTINCT', 'UNIQUE', 'GROUP BY', 'DIFFERENT', 'A', 2),
(1, 'Which garbage collector in modern Java provides ultra-low pause times for large heaps?', 'Serial GC', 'Parallel GC', 'ZGC', 'DefNew', 'C', 2),
(1, 'What is the default listening port for MySQL database instances?', '1521', '3306', '5432', '8080', 'B', 2);

-- Seed Past Score History
INSERT INTO exam_results (user_id, exam_id, total_questions, attempted, correct_answers, obtained_marks, percentage, status, attempted_at) VALUES
(1, 1, 10, 10, 9, 18, 90.0, 'PASSED', '2026-10-20 14:30:00'),
(1, 1, 10, 10, 8, 16, 80.0, 'PASSED', '2026-10-22 11:15:00'),
(1, 1, 10, 9, 7, 14, 70.0, 'PASSED', '2026-10-25 16:45:00');
