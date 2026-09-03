-- CUSTOMER DIMENSION --
CREATE OR REPLACE TABLE chinook.chinook_mart.dim_customer AS
SELECT 
  c.customer_id,
  c.customer_name AS full_name,
  c.company,
  c.customer_city AS city,
  c.customer_state AS state,
  c.customer_country AS country,
  c.customer_postal_code AS postal_code,
  c.customer_phone AS phone,
  c.customer_email AS email,
  c.support_rep_id,
  e.employee_name AS support_rep_name
FROM chinook.chinook_clean.customer AS c
LEFT JOIN chinook.chinook_clean.employee AS e 
  ON c.support_rep_id = e.employee_id;
