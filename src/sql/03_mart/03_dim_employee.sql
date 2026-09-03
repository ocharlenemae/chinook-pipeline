-- EMPLOYEE DIMENSION --
CREATE OR REPLACE TABLE chinook.chinook_mart.dim_employee AS
SELECT 
  employee_id,
  employee_name,
  title
FROM chinook.chinook_clean.employee;
