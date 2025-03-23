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