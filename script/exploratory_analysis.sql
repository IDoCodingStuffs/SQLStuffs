-------------------------------
-- Table-by-table exploration--
-------------------------------
--List of tables:
--sections
--instructors
--course_offerings
--subject_memberships
--courses
--rooms
--teachings
--subjects
--schedules
--grade_distributions

---------------------------------------
-- 1) Exploratory analysis for sections

SELECT TOP 5 * FROM sections; --Table head, cols: uuid, course_offering_uuid, section_type, number, room_uuid, schedule_uuid

SELECT COUNT(*) FROM sections; --Total rows: 315602

SELECT section_type, COUNT(section_type) AS count --Count of each section type
FROM sections -- 6 types: LEC, IND, DIS, LAB, FLD, SEM
GROUP BY section_type
ORDER BY count DESC;

-- number more than likely is the section no and the rest of the fields are keys.

-----------------------------------
-- 2) Analysis for course offerings

SELECT TOP 5 * FROM course_offerings; --Table head. Cols: uuid, course_uuid, term_code, name
-- Shared key uuid with sections table

SELECT COUNT(*) FROM course_offerings; --Total rows: 81452

SELECT term_code, COUNT(term_code) AS count --Count of each term code
FROM course_offerings -- Term ex. Spring 2018
GROUP BY term_code -- Unclear how terms are coded
ORDER BY count DESC; -- 22 unique terms included in data

SELECT name, COUNT(name) AS count --Count of each course offering name
FROM course_offerings -- 8242 Unique course offerings
GROUP BY name -- 2536 nulls though, to investigate further
ORDER BY count DESC;

--------------------------
-- 3) Analysis for courses

SELECT TOP 5 * FROM courses; --Table head. Cols: uuid, name, number
-- Shared key uuid with sections and course_offerings table
-- uuid possibly the course key?

SELECT COUNT(*) FROM courses; --Total rows: 9306

SELECT name, COUNT(name) AS count --Count of each unique course name
FROM courses -- 7921 Unique courses
GROUP BY name
ORDER BY count DESC;

-- What about course numbers? Different types of or tiers for a given course?
SELECT name, number --Count of each unique course-number combo
FROM courses -- 8522 Unique combinations
GROUP BY name, number; -- Seems like same uuid can be assigned to the same course multiple times
-- Maybe uuid is something else?

--------------------------
-- 4) Analysis for grade_distribution

SELECT TOP 5 * FROM grade_distributions; --Table head. Cols: course_offering_uuid, section numbers, count per grade (column per each grade), 

SELECT COUNT(*) FROM grade_distributions; --Total rows: 193262
