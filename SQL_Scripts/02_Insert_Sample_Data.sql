-- Insert sample departments
-- Insert sample departments
INSERT INTO departments (department_name, location, contact_email) VALUES
('Computer Science', 'Building A, Floor 2', 'cs@university.edu'),
('Mathematics', 'Building B, Floor 1', 'math@university.edu'),
('Physics', 'Building C, Floor 3', 'physics@university.edu');
SELECT * FROM departments;

-- Insert sample faculty members
INSERT INTO faculty (first_name, last_name, email, department_id, hire_date) VALUES
('John', 'Smith', 'john.smith@university.edu', 1, '2020-08-15'),
('Mary', 'Johnson', 'mary.johnson@university.edu', 1, '2019-06-01'),
('Robert', 'Williams', 'robert.williams@university.edu', 2, '2021-01-10');
SELECT * FROM faculty;
-- Insert sample students
INSERT INTO students (first_name, last_name, date_of_birth, email) VALUES
('Alice', 'Johnson', '2001-06-15', 'alice@example.com'),
('Bob', 'Smith', '2002-03-22', 'bob@example.com'),
('Carol', 'Williams', '2001-11-30', 'carol@example.com'),
('David', 'Brown', '2002-08-05', 'david@example.com');
SELECT * FROM students;

-- Insert sample courses
INSERT INTO courses (course_code, course_name, credits, department_id, faculty_id, max_capacity) VALUES
('CS101', 'Introduction to Programming', 3, 1, 1, 30),
('CS201', 'Data Structures', 4, 1, 2, 25),
('MATH101', 'Calculus I', 4, 2, 3, 35);
SELECT * FROM courses;
-- Insert sample enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade, status) VALUES
(1, 1, '2024-09-01', 85.50, 'active'),
(1, 2, '2024-09-01', 92.00, 'active'),
(2, 1, '2024-09-02', 78.75, 'active'),
(3, 3, '2024-09-01', 88.25, 'active');

SELECT * FROM enrollments;