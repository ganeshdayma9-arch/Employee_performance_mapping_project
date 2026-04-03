CREATE VIEW high_salary_employees AS
SELECT EMP_ID, FIRST_NAME, LAST_NAME, COUNTRY, SALARY
FROM emp_record_table
WHERE SALARY > 6000;

DELIMITER $$
CREATE PROCEDURE get_employee_exp_gt_3()
BEGIN
SELECT * FROM emp_record_table WHERE EXP > 3;
END $$
DELIMITER ;

DELIMITER $$
CREATE FUNCTION check_job_profile(exp INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
    DECLARE job_role VARCHAR(50);

    IF exp <= 2 THEN
        SET job_role = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp <= 5 THEN
        SET job_role = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp <= 10 THEN
        SET job_role = 'SENIOR DATA SCIENTIST';
    ELSE
        SET job_role = 'MANAGER';
    END IF;

    RETURN job_role;
END $$
DELIMITER ;

CREATE INDEX idx_first_name 
ON emp_record_table(FIRST_NAME);

