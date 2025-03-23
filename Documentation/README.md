# University Course Registration System

## Project Overview
This project implements a database system for managing university course registrations, including students, courses, faculty, and departments.

## Directory Structure
```
university_course_registration/
├── SQL_Scripts/           # Database creation and sample data
├── ER_Diagram/           # Database design diagrams
├── Query_Results/        # Example query outputs
├── Documentation/        # Project documentation
└── Submission/          # Final submission package
```

## Setup Instructions

1. Create the database:
```sql
CREATE DATABASE university_registration;
USE university_registration;
```

2. Run the SQL scripts in order:
   - 01_Create_Tables.sql
   - 02_Insert_Sample_Data.sql
   - 03_Queries.sql
   - 04_Bonus_Triggers_Procedures.sql (optional)

## Requirements
- MySQL 8.0 or later
- MySQL Workbench (recommended for viewing ER diagram)
