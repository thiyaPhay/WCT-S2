# Entity and Relationship Analysis

## Core Entities

### Students
- Properties: student_id, first_name, last_name, date_of_birth, email
- Relationships: Can register for multiple courses through enrollments

### Courses
- Properties: course_id, course_code, course_name, credits, max_capacity
- Relationships: 
  - Taught by one faculty member
  - Belongs to one department
  - Can have multiple student enrollments

### Faculty
- Properties: faculty_id, first_name, last_name, email, hire_date
- Relationships:
  - Belongs to one department
  - Can teach multiple courses

### Departments
- Properties: department_id, department_name, location, contact_email
- Relationships:
  - Contains multiple faculty members
  - Offers multiple courses

### Enrollments
- Properties: enrollment_id, enrollment_date, grade, status
- Relationships:
  - Links students to courses
  - Represents a many-to-many relationship between students and courses

## Relationships

1. Student-Course (Many-to-Many)
   - Implemented through Enrollments table
   - Each student can enroll in multiple courses
   - Each course can have multiple students

2. Faculty-Department (Many-to-One)
   - Each faculty member belongs to exactly one department
   - Each department can have multiple faculty members

3. Course-Department (Many-to-One)
   - Each course belongs to one department
   - Each department can offer multiple courses

4. Course-Faculty (Many-to-One)
   - Each course is taught by one faculty member
   - Each faculty member can teach multiple courses
