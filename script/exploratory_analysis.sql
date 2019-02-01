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
SELECT COUNT(*) FROM courses; --Total rows: 9306

SELECT name, COUNT(name) AS count --Count of each unique course name
FROM courses -- 7921 Unique courses
GROUP BY name
ORDER BY count DESC;

-- What about course numbers? Different types of or tiers for a given course?
SELECT name, number --Count of each unique course-number combo
FROM courses -- 8522 Unique combinations
GROUP BY name, number; -- Seems like same uuid can be assigned to the same course multiple times

-- Shared key uuid with sections and course_offerings table
-- uuid possibly the course key?
-- Maybe something else?

--------------------------
-- 4) Analysis for grade_distribution

SELECT TOP 5 * FROM grade_distributions; --Table head. Cols: course_offering_uuid, section numbers, count per grade (column per each grade) 
SELECT COUNT(*) FROM grade_distributions; --Total rows: 193262

-- This is likely aggregated from student data, which is likely not included because sensitive info and all that.
-- Further analysis outside scope of exploration

------------------------------------
-- 5) Analysis for instructors

SELECT TOP 5 * FROM instructors; --Table head. Cols: id, name
SELECT COUNT(*) FROM instructors; --Total rows: 18737

-- This is just a reference table to look up instructor names from id

----------------------------------------
-- 6) Analysis for rooms

SELECT TOP 5 * FROM rooms; --Table head. Cols: uuid, facility_code, room_code
SELECT COUNT(*) FROM rooms; --Total rows: 1350

SELECT facility_code, COUNT(facility_code) AS count --Count of each unique facility code
FROM rooms -- 132 unique facility codes
GROUP BY facility_code -- Likely for administrative convenience, although ONLINE course info contained
ORDER BY count DESC;

--------------------------------------
-- 7) Analysis for schedules

SELECT TOP 5 * FROM schedules; --Table head. Cols: uuid, start_time, end_time, col per day of week
SELECT COUNT(*) FROM schedules; --Total rows: 4467

SELECT start_time FROM schedules -- All unique start times
GROUP BY start_time -- The time notations do not fit hour notations
ORDER BY start_time DESC; -- Although first two fit 24 hour notations, last 2 likely code

SELECT end_time FROM schedules -- All unique end times
GROUP BY end_time -- The time notations do not fit hour notations either, although make sense for mins
ORDER BY end_time DESC; -- Possibly coded as (hour x 60 + minute) to denote hour and minute 

SELECT start_time, COUNT(start_time) AS count -- Count of each unique start time
FROM schedules -- In descending order
GROUP BY start_time -- The expectation is that the most popular times will make sense for a college
ORDER BY count DESC; -- For the (hour x 60 + minute theory)

SELECT end_time, COUNT(end_time) AS count -- Count of each unique start time
FROM schedules -- In descending order
GROUP BY end_time -- The expectation is that the most popular times will make sense for a college
ORDER BY count DESC; -- For the (hour x 60 + minute theory)

-- If the theory is correct, the most popular 3 start dates would be: 13:20, 14:25 and 11:00
-- The most popular end times would be: 17:00, 10:45 and 16:00
-- Most likely makes sense, can be used as the logic for data cleaning

-- 8) Analysis for subject_memberships

SELECT TOP 5 * FROM subject_memberships; --Table head. Cols: subject_code, course_offering_uuid
SELECT COUNT(*) FROM subject_memberships; --Total rows: 95314

-- Most likely a lookup table. Given how both cols are keys. Likely between course_offerings and subjects

-------------------------------------------------------
-- 9) Analysis for subjects

SELECT TOP 5 * FROM subjects; --Table head. Cols: code, name, abbreviation
SELECT COUNT(*) FROM subjects; --Total rows: 200

-- Subject reference table. Code is shared key linked with subject_memberships which is linked with course_offerings

----------------------------------------------------------
-- 10) Analysis for teachings

SELECT TOP 5 * FROM teachings; --Table head. Cols: instructor_id, section_uuid
SELECT COUNT(*) FROM teachings; --Total rows: 315211

-- Likely reference table between instructors and sections

------------------------------------------------------

/*
With this information we can generate database schema as well as a simple report explaining what is 
going on with the dataset
*/