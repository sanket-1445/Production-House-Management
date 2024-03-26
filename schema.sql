CREATE DATABASE IF NOT EXISTS prod;
USE prod;

CREATE TABLE productions (
    production_id INT NOT NULL AUTO_INCREMENT,
    production_firm VARCHAR(255) NOT NULL,
    PRIMARY KEY (production_id)
);

CREATE TABLE departments (
    department_id INT NOT NULL AUTO_INCREMENT,
    department_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (department_id)
);

CREATE TABLE Series (
  SeriesID INT NOT NULL AUTO_INCREMENT,
  SeriesName VARCHAR(255) NOT NULL,
  Reviews INT,
  Budget DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (SeriesID)
);

CREATE TABLE produces (
 production_id INT NOT NULL,
 SeriesID INT NOT NULL ,
 FOREIGN KEY (production_id) REFERENCES productions(production_id),
 FOREIGN KEY (SeriesID) REFERENCES Series(SeriesID)
);

CREATE TABLE Genre (
  SeriesID INT,
  genre_type VARCHAR(255),
  FOREIGN KEY (SeriesID) REFERENCES Series(SeriesID)
);

CREATE TABLE employees (
    emp_id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255),
    DOB DATE,
    department_id INT NOT NULL,
    PRIMARY KEY (emp_id),
    FOREIGN KEY (department_id) REFERENCES departments (department_id)
);

CREATE TABLE works_for (
	Seriesid INT NOT NULL,
    emp_id INT NOT NULL,
    FOREIGN KEY (SeriesID) REFERENCES Series(SeriesID),
	FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

CREATE TABLE has_departments (
    department_id INT NOT NULL,
    production_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments (department_id),
    FOREIGN KEY (production_id) REFERENCES productions (production_id)
);

CREATE TABLE Cast (
  cast_id INT NOT NULL AUTO_INCREMENT,
  emp_id INT NOT NULL,
  num_of_episodes INT NOT NULL,
  name_in_series VARCHAR(255) NOT NULL,
  PRIMARY KEY (cast_id),
  FOREIGN KEY (emp_id) REFERENCES employees (emp_id)
);

CREATE TABLE CrewMembers (
  crew_member_id INT NOT NULL AUTO_INCREMENT,
  emp_id INT NOT NULL,
  contract_duration INT NOT NULL,
  designation VARCHAR(255) NOT NULL,
  PRIMARY KEY (crew_member_id),
  FOREIGN KEY (emp_id) REFERENCES employees (emp_id)
);

CREATE TABLE Script_writer (
  script_id INT NOT NULL AUTO_INCREMENT,
  script_name VARCHAR(255) NOT NULL,
  emp_id INT NOT NULL,
  PRIMARY KEY (script_id),
   FOREIGN KEY (emp_id) REFERENCES employees (emp_id)
);

CREATE TABLE Grievances (
    emp_id INT NOT NULL,
    grievance_text TEXT,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id),
    PRIMARY KEY (emp_id)
);

CREATE TABLE ReleaseGroup (
    R_ID INT NOT NULL AUTO_INCREMENT,
    Platform VARCHAR(255),
    ReleaseDate DATE,
    SeriesID INT,
    PRIMARY KEY (R_ID),
    FOREIGN KEY (SeriesID) REFERENCES Series(SeriesID),
    UNIQUE KEY (R_ID, SeriesID)
);

INSERT INTO productions (production_firm,production_id) VALUES
('FilmCo Enterprises',1),
('GreatFilms Inc.',2);

INSERT INTO departments (department_name, department_id) VALUES
('Production', 1),
('Finance', 2),
('Scriptwriting', 11),
('Casting', 12),
('Cinematography', 13),
('Costume and Makeup', 15),
('Set Design', 16),
('Editing', 17);


INSERT INTO has_departments(department_id,production_id) VALUES 
(1,1),
(2,1),
(11,1),
(12,1),
(13,1),
(15,1),
(16,1),
(17,1),
(1,2),
(2,2),
(11,2),
(12,2),
(13,2),
(15,2),
(16,2),
(17,2);


INSERT INTO Series (SeriesName, Reviews, Budget,SeriesID) VALUES
('Stranger Things', 850, 12000000.00,1),
('Game of Thrones', 980, 18000000.00,2),
('Breaking Bad', 920, 10000000.00,3),
('Money Heist', 910, 16000000.00,4),
('Peaky Blinders', 920, 10500000.00,5);


INSERT INTO produces (production_id, SeriesID) VALUES
(1, 1),
(2, 2),
(2, 3),
(1, 4),
(2, 5);


INSERT INTO Genre (SeriesID, genre_type) VALUES
(1, 'Drama'),
(2, 'Science Fiction'),
(2,'Drama'),
(3, 'Fantasy'),
(4, 'Drama'),
(4, 'Comedy'),
(5, 'Fantasy'),
(5, 'Crime');

INSERT INTO employees (first_name, last_name, middle_name, DOB, department_id,emp_id) VALUES
('John', 'Doe', 'A.', '1985-02-10', 1, 214),
('Jane', 'Smith', 'B.', '1990-07-15', 1, 501),
('Michael', 'Johnson', NULL, '1988-04-20', 1, 789),
('Emily', 'Williams', 'C.', '1995-01-30', 2, 327),
('Chris', 'Brown', 'D.', '1982-11-05', 2, 611),
('Sophie', 'Anderson', 'V.', '1984-07-01', 11, 464),
('Daniel', 'Hall', 'W.', '1997-05-14', 11, 577),
('Ella', 'Thompson', 'X.', '1992-09-26', 11, 200),
('Mia', 'Moore', 'Z.', '1988-12-03', 11, 493),
('Henry', 'Robinson', 'EE.', '1998-11-30', 11, 436),
('Daniel', 'Nguyen', 'I.', '1996-10-22', 12, 357),
('John', 'Smith', 'A.', '1995-08-15', 12, 614),
('Sarah', 'Johnson', 'B.', '1990-04-03', 12, 843),
('Michael', 'Williams', 'C.', '1987-11-21', 12, 268),
('Emily', 'Davis', 'D.', '1998-02-12', 12, 672),
('Matthew', 'Brown', 'E.', '1993-09-28', 12, 112),
('Jennifer', 'Lee', 'F.', '1985-07-19', 12, 364),
('Christopher', 'Miller', 'G.', '1991-06-14', 12, 976),
('Jessica', 'Wilson', 'H.', '1994-03-02', 12, 481),
('David', 'Anderson', 'J.', '1988-12-07', 12, 795),
('Melissa', 'Thompson', 'K.', '1997-01-25', 12, 653),
('Andrew', 'Harris', 'L.', '1992-10-09', 12, 164),
('Linda', 'Martinez', 'M.', '1986-05-31', 12, 742),
('William', 'Garcia', 'N.', '1989-08-26', 12, 558),
('Amanda', 'Robinson', 'O.', '1999-04-17', 12, 351),
('James', 'Clark', 'P.', '1996-11-04', 12, 784),
('Elizabeth', 'Wright', 'Q.', '1984-12-30', 12, 416),
('Daniel', 'Turner', 'R.', '1990-02-22', 12, 799),
('Maria', 'Adams', 'S.', '1997-07-08', 12, 686),
('Kevin', 'Evans', 'T.', '1993-03-16', 12, 238),
('Olivia', 'Perez', 'U.', '1998-09-12', 12, 572),
('Ryan', 'Jackson', 'V.', '1994-06-25', 12, 816),
('Stephanie', 'Hernandez', 'W.', '1991-01-03', 12, 494),
('Joseph', 'Moore', 'X.', '1987-10-17', 12, 765),
('Natalie', 'Hall', 'Y.', '1995-04-05', 12, 147),
('Robert', 'Scott', 'Z.', '1988-05-19', 12, 467),
('Megan', 'Baker', 'AA.', '1992-08-29', 12, 854),
('Thomas', 'King', 'BB.', '1986-12-13', 12, 752),
('Samantha', 'Young', 'CC.', '1999-05-07', 12, 413),
('Benjamin', 'Lopez', 'DD.', '1996-07-23', 12, 226),
('Emma', 'Adams', 'EE.', '1993-03-11', 12, 619),
('Jessica', 'Lee', 'E.', '1993-08-18', 13, 748),
('David', 'Garcia', NULL, '1986-09-25', 13, 403),
('Ashley', 'Martinez', 'F.', '1991-03-12', 13, 175),
('Matthew', 'Lopez', 'G.', '1998-06-07', 15, 546),
('William', 'Clark', NULL, '1981-06-12', 15, 172),
('Sarah', 'Scott', 'H.', '1980-12-28', 15, 217),
('Ava', 'Rodriguez', 'J.', '1992-02-17', 16, 621),
('Kevin', 'Gonzalez', NULL, '1983-07-09', 16, 971),
('Lauren', 'Taylor', 'K.', '1997-11-02', 16, 465),
('Andrew', 'Hernandez', 'L.', '1989-04-15', 16, 873),
('Grace', 'King', NULL, '1994-09-10', 17, 286),
('Brandon', 'White', 'M.', '1987-01-25', 17, 347),
('Hannah', 'Moore', 'N.', '1999-08-08', 17, 586);

INSERT INTO works_for (SeriesID, emp_id) VALUES
(1, 357),
(2, 614),
(3, 843),
(4, 268),
(5, 672),
(1, 214),
(2, 214),
(3, 789),
(4, 501),
(5, 789),
(1, 327),
(2, 611),
(3, 611),
(4, 327),
(5, 611),
(1, 748),
(2, 403),
(3, 175),
(4, 403),
(5, 175),
(1, 172),
(2, 217),
(3, 546),
(4, 546),
(5, 217),
(1, 621),
(2, 971),
(3, 465),
(4, 873),
(5, 971),
(1, 286),
(2, 347),
(3, 586),
(4, 286),
(5, 586),
(1, 464),
(2, 577),
(3, 238),
(4, 493),
(5, 436),
(1,112),
(1,364),
(1,976),
(1,481),
(2,795),
(2,653),
(2,164),
(2,742),
(2,558),
(2,351),
(2,784),
(3,416),
(3,799),
(3,686),
(4,238),
(4,572),
(4,816),
(4,494),
(4,765),
(5,147),
(5,467),
(5,854),
(5,752),
(5,413),
(5,226),
(2,619);


INSERT INTO Cast (emp_id, num_of_episodes, name_in_series) VALUES
(112, 22, 'Chris Brown'),
(364, 28, 'Jessica Lee'),
(976, 23, 'David Garcia'),
(481, 26, 'Ashley Martinez'),
(795, 21, 'Matthew Lopez'),
(653, 27, 'Sarah Scott'),
(164, 29, 'Olivia Adams'),
(742, 19, 'Daniel Nguyen'),
(558, 24, 'Ava Rodriguez'),
(351, 31, 'Kevin Gonzalez'),
(784, 17, 'Lauren Taylor'),
(416, 20, 'Andrew Hernandez'),
(799, 28, 'Grace King'),
(686, 19, 'Liam Martin'),
(238, 23, 'Mia Moore'),
(572, 30, 'William Harris'),
(816, 15, 'Olivia Brown'),
(494, 18, 'James Davis'),
(765, 28, 'Charlotte Martinez'),
(147, 17, 'Henry Robinson'),
(467, 20, 'Ava Garcia'),
(854, 29, 'Noah Taylor'),
(752, 26, 'Amelia Williams'),
(413, 25, 'Brandon White'),
(226, 22, 'Hannah Moore'),
(619, 30, 'William Clark');


INSERT INTO CrewMembers (emp_id, contract_duration, designation) VALUES
(214, 12, 'Head of Production'),
(501, 10, 'Head of Production'),
(789, 11, 'Head of Production'),
(327, 9, 'Head of Finance'),
(611, 8, 'Head of Finance'),
(748, 13, 'Head of Cinematography'),
(403, 14, 'Head of Cinematography'),
(175, 10, 'Head of Cinematography'),
(546, 12, 'Head of Constume and Makeup'),
(217,10, 'Head of Constume and Makeup'),
(172, 10, 'Head of Constume and Makeup'),
(357,9,'Head of Castig'),
(614,8,'Head of Castig'),
(843,11,'Head of Castig'),
(268,8,'Head of Castig'),
(672,10,'Head of Castig'),
(621, 16, 'Head of Set Design'),
(971, 10, 'Head of Set Design'),
(465, 11, 'Head of Set Design'),
(873, 8, 'Head of Set Design'),
(286, 12, 'Head of Editing'),
(347, 13, 'Head of Editing'),
(586, 9, 'Head of Editing');


INSERT INTO Script_writer (script_name, script_id,emp_id) VALUES
('Stranger Things Script', 2,464),
('Game of Thrones Script', 3,577),
('Breaking Bad Script', 4,200),
('Money Heist Script', 6,493),
('Peaky Blinders Script', 11,436);


INSERT INTO Grievances (emp_id, grievance_text) VALUES
(214, 'Salary concern'),
(501, 'Workload issue'),
(789, 'Conflict with colleague'),
(327, 'Overtime problem'),
(611, 'Seeking leave'),
(464, 'Equipment malfunction'),
(577, 'Communication problem'),
(200, 'Training requirement'),
(493, 'Resource shortage'),
(436, 'Safety concern'),
(357, 'Ethical dilemma'),
(614, 'Job satisfaction'),
(843, 'Performance appraisal'),
(268, 'Workplace culture'),
(672, 'Diversity and inclusion'),
(112, 'Health and wellness'),
(364, 'Management issue'),
(976, 'Work-life balance'),
(481, 'Career growth'),
(795, 'Job security'),
(653, 'Inadequate conflict resolution processes'),
(164, 'Lack of clear company ethics'),
(742, 'Inadequate professional development opportunities'),
(558, 'Unfair termination or layoff'),
(351, 'Lack of work-related benefits'),
(784, 'Inadequate employee recognition programs'),
(416, 'Lack of innovation opportunities'),
(799, 'Ineffective employee onboarding'),
(686, 'Lack of support for mental health'),
(238, 'Inadequate feedback mechanisms'),
(572, 'Lack of alignment with company values'),
(816, 'Ineffective team communication'),
(494, 'Unresolved workplace conflicts'),
(765, 'Inadequate performance evaluation'),
(147, 'Employee turnover and retention issues'),
(467, 'Lack of clear project goals'),
(854, 'Inadequate recognition of extra hours worked'),
(752, 'Inadequate disability accommodations'),
(413, 'Lack of opportunities for career change'),
(226, 'Ineffective time management'),
(619, 'Inadequate company resources'),
(748, 'Lack of support for remote workers'),
(403, 'Ineffective conflict mediation'),
(175, 'Lack of mental health programs'),
(546, 'Inadequate diversity and inclusion efforts'),
(172, 'Employee privacy concerns'),
(217, 'Lack of company-wide training programs'),
(621, 'Inadequate work-related communication'),
(971, 'Lack of support for employee well-being'),
(465, 'Ineffective employee performance reviews'),
(873, 'Lack of clear company mission'),
(286, 'Inadequate job security measures'),
(347, 'Unresolved grievances'),
(586, 'Lack of support for remote meetings');


INSERT INTO ReleaseGroup (Platform, ReleaseDate, SeriesID) VALUES
('Netflix', '2023-01-15', 1),
('Netflix', '2023-03-20', 2),
('HBO', '2023-05-10', 3),
('AMC', '2023-06-05', 4),
('Netflix', '2023-08-12', 5);


INSERT INTO Series (SeriesID, SeriesName, Reviews, Budget) VALUES 
(21, 'Mystery Quest', 0, 0.00);

INSERT INTO Genre (SeriesID, genre_type) VALUES 
(3, 'Mystery'),
(3, 'Adventure');

SELECT p.production_id, p.production_firm, d.department_id, d.department_name
FROM productions as p
JOIN has_departments hd ON p.production_id = hd.production_id
JOIN departments d ON hd.department_id = d.department_id;

SELECT s.SeriesID, s.SeriesName, s.Reviews, s.Budget, g.genre_type
FROM Series s
LEFT JOIN Genre g ON s.SeriesID = g.SeriesID;

SELECT e.emp_id, e.first_name, e.last_name, e.middle_name, e.DOB, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

SELECT c.cast_id, e.first_name, e.last_name, c.num_of_episodes, c.name_in_series, s.SeriesName
FROM Cast c
JOIN employees e ON c.emp_id = e.emp_id
JOIN works_for w ON e.emp_id = w.emp_id
JOIN Series s ON w.Seriesid = s.SeriesID;

SELECT g.emp_id, e.first_name, e.last_name, g.grievance_text
FROM Grievances g
JOIN employees e ON g.emp_id = e.emp_id;

SELECT cm.crew_member_id, e.first_name, e.last_name, cm.contract_duration, cm.designation
FROM CrewMembers cm
JOIN employees e ON cm.emp_id = e.emp_id;

SELECT sw.script_id, e.first_name, e.last_name, sw.script_name
FROM Script_writer sw
JOIN employees e ON sw.emp_id = e.emp_id;

SELECT rg.R_ID, rg.Platform, rg.ReleaseDate, s.SeriesName
FROM ReleaseGroup rg
JOIN Series s ON rg.SeriesID = s.SeriesID;

SELECT SeriesID, GROUP_CONCAT(genre_type) AS Genres
FROM Genre
GROUP BY SeriesID;

SELECT emp_id, first_name, last_name, DOB, YEAR(CURDATE()) - YEAR(DOB) AS age
FROM employees;