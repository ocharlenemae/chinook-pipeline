-- DATE DIMENSION --
CREATE OR REPLACE TABLE chinook.chinook_mart.dim_date AS
SELECT DISTINCT
  INT(DATE_FORMAT(invoice_date, 'yyyyMMdd')) AS date_key,
  invoice_date AS date,
  DATE_FORMAT(invoice_date, 'MMM yyyy') AS month_and_year,
  DATE_FORMAT(invoice_date, 'yyyy-\QQ') AS year_and_quarter
FROM chinook.chinook_clean.invoice;
