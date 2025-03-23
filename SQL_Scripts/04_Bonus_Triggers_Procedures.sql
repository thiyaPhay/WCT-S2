USE university_management;

-- Trigger to update student's GPA when a grade is updated
DELIMITER //
CREATE TRIGGER update_student_gpa
AFTER UPDATE ON enrollments
FOR EACH ROW
BEGIN
    IF NEW.status = 'completed' THEN
        UPDATE students s
        SET gpa = (
            SELECT COALESCE(AVG(grade), 0)
            FROM enrollments
            WHERE student_id = NEW.student_id
            AND status = 'completed'
            AND grade IS NOT NULL
        )
        WHERE s.student_id = NEW.student_id;
    END IF;
END //
DELIMITER ;

-- Stored procedure to enroll a student in a course
DELIMITER //
DROP PROCEDURE IF EXISTS enroll_student //
CREATE PROCEDURE enroll_student(
    IN p_student_id INT,
    IN p_course_code VARCHAR(10),
    OUT p_success BOOLEAN
)
BEGIN
    DECLARE v_course_id INT;
    DECLARE v_current_enrolled INT;
    DECLARE v_max_capacity INT;
    
    -- Initialize success as false
    SET p_success = FALSE;
    
    -- Get course information
    SELECT course_id, max_capacity
    INTO v_course_id, v_max_capacity
    FROM courses
    WHERE course_code = p_course_code;
    
    -- Check if course exists
    IF v_course_id IS NOT NULL THEN
        -- Check current enrollment count
        SELECT COUNT(*)
        INTO v_current_enrolled
        FROM enrollments
        WHERE course_id = v_course_id
        AND status = 'active';
        
        -- Check if there's space available and student isn't already enrolled
        IF v_current_enrolled < v_max_capacity 
        AND NOT EXISTS (
            SELECT 1 
            FROM enrollments 
            WHERE student_id = p_student_id 
            AND course_id = v_course_id 
            AND status = 'active'
        ) THEN
            -- Enroll the student
            INSERT INTO enrollments (student_id, course_id, enrollment_date, status)
            VALUES (p_student_id, v_course_id, CURRENT_DATE, 'active');
            SET p_success = TRUE;
        END IF;
    END IF;
END //
DELIMITER ;

--- Test Case 1: Update a grade and check GPA update
UPDATE enrollments 
SET grade = 90.00, status = 'completed'
WHERE student_id = 1 AND course_id = 1;
ALTER TABLE students ADD COLUMN gpa DECIMAL(4,2) DEFAULT 0.00;

-- Check the updated GPA
SELECT s.student_id, s.first_name, s.last_name, s.gpa
FROM students s
WHERE student_id = 1;

-- Test Case 2: Try to enroll in a course with available space
CALL enroll_student(2, 'MATH101', @success);
SELECT 'Enrollment Test 1 Result' as test_case, @success as success_status;

-- Check enrollment result
SELECT s.first_name, s.last_name, c.course_code, c.course_name, e.enrollment_date
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id = 2 AND c.course_code = 'MATH101';

-- Test Case 3: Try to enroll in a full course
-- First, update course capacity to current enrollment count
UPDATE courses SET max_capacity = 1 WHERE course_code = 'CS101';

 -- Try enrolling another student
CALL enroll_student(3, 'CS101', @success);
SELECT 'Enrollment Test 2 Result' as test_case, @success as success_status;

 -- View current enrollments in CS101
SELECT c.course_code, c.max_capacity, COUNT(e.student_id) as current_enrolled
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
WHERE c.course_code = 'CS101'
GROUP BY c.course_id, c.course_code, c.max_capacity;