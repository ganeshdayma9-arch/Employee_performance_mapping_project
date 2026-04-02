CREATE DATABASE employee;
USE employee;

CREATE TABLE emp_record_table(
EMP_ID VARCHAR (10) PRIMARY KEY,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR (50),
GENDER VARCHAR (10),
ROLE VARCHAR (50),
DEPT VARCHAR (50),
EXP int,
COUNTRY VARCHAR (50),
CONTINENT varchar (50),
SALARY INT,
EMP_RATING INT,
MANAGER_ID VARCHAR(10),
PROJ_ID VARCHAR(10));

SELECT * FROM emp_record_table; 


CREATE TABLE Proj_table(
PROJECT_ID VARCHAR(10)PRIMARY KEY,
PROJ_NAME VARCHAR (100),
DOMAIN VARCHAR (50),
START_DATE VARCHAR (20),
CLOSURE_DATE VARCHAR (20),
DEV_QTR VARCHAR(10),
STATUS VARCHAR (20));

SELECT * FROM proj_table;

CREATE TABLE Data_science_team(
EMP_ID VARCHAR(10) PRIMARY KEY,
FIRST_NAME VARCHAR(50),
LAST_NAME VARCHAR(50),
GENDER VARCHAR(10),
ROLE VARCHAR (50),
DEPT VARCHAR (50),
EXP INT,
COUNTRY VARCHAR(50),
CONTINENT VARCHAR (50));

SELECT * FROM Data_science_team;



SELECT 
    EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM
    emp_record_table;
 
 
 SELECT EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT,EMP_RATING
 FROM emp_record_table WHERE EMP_RATING <2;
 
 SELECT EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT,EMP_RATING
 FROM emp_record_table WHERE EMP_RATING >4;

SELECT EMP_ID,FIRST_NAME,LAST_NAME,GENDER,DEPT,EMP_RATING
 FROM emp_record_table WHERE EMP_RATING BETWEEN 2 AND 4;
 
 
 
 SELECT 
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM
    emp_record_table
WHERE
    DEPT = 'Finance';
    
    
    
    SELECT 
    m.EMP_ID,
    m.FIRST_NAME,
    m.LAST_NAME,
    COUNT(e.EMP_ID) AS NUMBER_OF_REPORTERS
FROM
    emp_record_table m
        JOIN
    emp_record_table e ON m.EMP_ID = e.MANAGER_ID
GROUP BY m.EMP_ID , m.FIRST_NAME , m.LAST_NAME; 




SELECT 
    *
FROM
    emp_record_table
WHERE
    DEPT = 'Healthcare' 
UNION SELECT 
    *
FROM
    emp_record_table
WHERE
    DEPT = 'Finance';

    
    
    SELECT EMP_ID,FIRST_NAME,LAST_NAME,ROLE,DEPT,EMP_RATING , 
  max(EMP_RATING) OVER (partition by DEPT) AS MAX_DEPT_RATING
  FROM emp_record_table;
    
    
    
    
    
    
 SELECT 
    ROLE, MIN(SALARY) AS MIN_SALARY, MAX(SALARY) AS MAX_SALARY
FROM
    emp_record_table
GROUP BY ROLE;



SELECT EMP_ID,FIRST_NAME,LAST_NAME,EXP, 
RANK() OVER (order by EXP DESC) AS EXP_RANK
FROM emp_record_table;




CREATE VIEW high_salary_employees AS
    SELECT 
        EMP_ID, FIRST_NAME, LAST_NAME, COUNTRY, SALARY
    FROM
        emp_record_table
    WHERE
        SALARY > 6000;
        
	SELECT * FROM high_salary_employees ;
    
    
    
    
    SELECT 
    EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM
    emp_record_table
WHERE
    EMP_ID IN (SELECT 
            EMP_ID
        FROM
            emp_record_table
        WHERE
            EXP > 10);
            
            
            
            
            
             DELIMITER $$
 CREATE  PROCEDURE get_employee_exp_gt_3()
 BEGIN
 SELECT EMP_ID,FIRST_NAME,LAST_NAME,GENDER,ROLE,DEPT,EXP,COUNTRY,CONTINENT,SALARY,EMP_RATING,MANAGER_ID
 FROM emp_record_table WHERE EXP > 3;
 END $$
 DELIMITER ;
 
 CALL get_employee_exp_gt_3();
 
 
 
 
 
 
 
DELIMITER $$

CREATE FUNCTION check_job_profile(exp INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE job_role VARCHAR(50);

    IF exp <= 2 THEN
        SET job_role = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp > 2 AND exp <= 5 THEN
        SET job_role = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp > 5 AND exp <= 10 THEN
        SET job_role = 'SENIOR DATA SCIENTIST';
    ELSEIF exp > 10 AND exp <= 12 THEN
        SET job_role = 'LEAD DATA SCIENTIST';
    ELSEIF exp > 12 AND exp <= 16 THEN
        SET job_role = 'MANAGER';
    ELSE
        SET job_role = 'NOT DEFINED';
    END IF;

    RETURN job_role;
END $$

DELIMITER ;
SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    EXP,
    ROLE AS ASSIGNED_ROLE,
    check_job_profile(EXP) AS STANDARD_ROLE,
    CASE
        WHEN ROLE = check_job_profile(EXP) THEN 'MATCH'
        ELSE 'MISMATCH'
    END AS ROLE_STATUS
FROM data_science_team;




EXPLAIN SELECT *
FROM emp_record_table
WHERE FIRST_NAME = 'Eric' ;

CREATE INDEX idx_first_name 
ON emp_record_table(FIRST_NAME);

EXPLAIN SELECT *
FROM emp_record_table 
WHERE FIRST_NAME = 'Eric';




SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    SALARY,
    EMP_RATING,
    (0.05 * SALARY * EMP_RATING) AS BONUS
FROM
    emp_record_table;
    
    
    SELECT 
    CONTINENT, COUNTRY, AVG(SALARY) AS Avg_Salary
FROM
    emp_record_table
GROUP BY CONTINENT , COUNTRY
ORDER BY CONTINENT , COUNTRY;










    

