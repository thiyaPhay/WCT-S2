# University Course Registration System

A university wants to develop a Course Registration System to manage student enrollments, courses, and faculty. The system should allow students to register for courses, track their progress, and allow faculty members to manage course content and student grades. Your task is to design and implement the database for this system, covering all steps from entity modeling to SQL table creation.

## Part 1: Identify Entities and Relationships

Analyze the scenario and identify the main entities involved in the system. Your design should include:
- **Students**: Can register for multiple courses.
- **Courses**: Each has a unique code and is taught by a faculty member.
- **Faculty**: Teaches multiple courses but belongs to only one department.
- **Departments**: Manages multiple faculty members and courses.
- **Enrollments**: Represents the relationship between students and courses, including enrollment date and grade.

## Part 2: Draw the ER Diagram

Use an ER diagram to model the relationships between the entities, defining primary keys, attributes, and cardinalities. Tools like MySQL Workbench or Draw.io can be used.

## Part 3: Transform the ER Model into Relational Tables

Convert your ER diagram into relational tables. Ensure to define primary keys, foreign keys, and constraints.

## Part 4: Create SQL Tables


```sql
-- Students table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100),
    contact_email VARCHAR(100)
);

-- Faculty table
CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    department_id INT NOT NULL,
    faculty_id INT NOT NULL,
    max_capacity INT CHECK (max_capacity > 0),
    FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (faculty_id) REFERENCES faculty(faculty_id)
);

-- Enrollments table
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    grade DECIMAL(4,2) CHECK (grade >= 0 AND grade <= 100),
    status ENUM('active', 'dropped', 'completed') DEFAULT 'active',
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    UNIQUE KEY unique_enrollment (student_id, course_id)
);
```

## Part 5: Insert Sample Data

```sql
-- Insert sample departments
INSERT INTO departments (department_name, location, contact_email) VALUES
('Computer Science', 'Building A, Floor 2', 'cs@university.edu'),
('Mathematics', 'Building B, Floor 1', 'math@university.edu'),
('Physics', 'Building C, Floor 3', 'physics@university.edu');

-- Insert sample faculty members
INSERT INTO faculty (first_name, last_name, email, department_id, hire_date) VALUES
('John', 'Smith', 'john.smith@university.edu', 1, '2020-08-15'),
('Mary', 'Johnson', 'mary.johnson@university.edu', 1, '2019-06-01'),
('Robert', 'Williams', 'robert.williams@university.edu', 2, '2021-01-10');

-- Insert sample students
INSERT INTO students (first_name, last_name, date_of_birth, email) VALUES
('Alice', 'Johnson', '2001-06-15', 'alice@example.com'),
('Bob', 'Smith', '2002-03-22', 'bob@example.com'),
('Carol', 'Williams', '2001-11-30', 'carol@example.com'),
('David', 'Brown', '2002-08-05', 'david@example.com');

-- Insert sample courses
INSERT INTO courses (course_code, course_name, credits, department_id, faculty_id, max_capacity) VALUES
('CS101', 'Introduction to Programming', 3, 1, 1, 30),
('CS201', 'Data Structures', 4, 1, 2, 25),
('MATH101', 'Calculus I', 4, 2, 3, 35);

-- Insert sample enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade, status) VALUES
(1, 1, '2024-09-01', 85.50, 'active'),
(1, 2, '2024-09-01', 92.00, 'active'),
(2, 1, '2024-09-02', 78.75, 'active'),
(3, 3, '2024-09-01', 88.25, 'active');
```

## Part 6: Querying the Database

```sql
-- 1. Retrieve all students who enrolled in a specific course
SELECT s.student_id, s.first_name, s.last_name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_code = 'CS101';

-- 2. Find all faculty members in a particular department
SELECT f.faculty_id, f.first_name, f.last_name, d.department_name
FROM faculty f
JOIN departments d ON f.department_id = d.department_id
WHERE d.department_name = 'Computer Science';

-- 3. List all courses a particular student is enrolled in
SELECT c.course_code, c.course_name, e.enrollment_date, e.grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
WHERE e.student_id = 1;

-- 4. Retrieve students who have not enrolled in any course
SELECT s.student_id, s.first_name, s.last_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

-- 5. Find the average grade of students in a specific course
SELECT c.course_name, AVG(e.grade) as average_grade
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
WHERE c.course_code = 'CS101'
GROUP BY c.course_id, c.course_name;
```

## Submission Guidelines

- ER Diagram (image or PDF).
- SQL file with CREATE TABLE and INSERT statements.
- SQL queries with explanations.
- Screenshots of query results.

## Bonus (Optional)

- Implement a trigger to update a student's GPA when a grade is updated.
- Design a stored procedure to enroll a student in a course.

## Bonus Implementation

```sql
-- Trigger to update student's GPA when a grade is updated
DELIMITER //
CREATE TRIGGER update_student_gpa
AFTER UPDATE ON enrollments
FOR EACH ROW
BEGIN
    UPDATE students s
    SET gpa = (
        SELECT AVG(grade)
        FROM enrollments
        WHERE student_id = NEW.student_id
        AND status = 'completed'
    )
    WHERE s.student_id = NEW.student_id;
END;
//
DELIMITER ;

-- Stored procedure to enroll a student in a course
DELIMITER //
CREATE PROCEDURE enroll_student(
    IN p_student_id INT,
    IN p_course_code VARCHAR(10),
    OUT p_success BOOLEAN
)
BEGIN
    DECLARE v_course_id INT;
    DECLARE v_current_enrolled INT;
    DECLARE v_max_capacity INT;
    
    -- Get course information
    SELECT course_id, max_capacity
    INTO v_course_id, v_max_capacity
    FROM courses
    WHERE course_code = p_course_code;
    
    -- Check current enrollment count
    SELECT COUNT(*)
    INTO v_current_enrolled
    FROM enrollments
    WHERE course_id = v_course_id
    AND status = 'active';
    
    -- Check if there's space available
    IF v_current_enrolled < v_max_capacity THEN
        -- Enroll the student
        INSERT INTO enrollments (student_id, course_id, enrollment_date)
        VALUES (p_student_id, v_course_id, CURRENT_DATE);
        SET p_success = TRUE;
    ELSE
        SET p_success = FALSE;
    END IF;
END;
//
DELIMITER ;
```
## Evaluation Criteria

- Correct entity identification and relationships.
- Well-structured ER diagram.
- Accurate transformation of entities into relational tables.
- Proper use of SQL constraints and normalization.
- Functional SQL queries that return correct results.