--  MONTHLY SALES TREND --
-- Tracks monthly total invoice revenue over the 2-year window (Jan 2024 - Dec 2025). --
CREATE OR REPLACE TABLE chinook.chinook_visualization.monthly_sales_trend AS
SELECT
  DATE_TRUNC('month', d.date) AS date_month,   
  d.year AS sales_year,                       
  d.month_name AS sales_month,                
  d.month_and_year AS month_year_str,          
  ROUND(SUM(f.total_revenue), 2) AS total_revenue
FROM chinook.chinook_mart.fact_invoice_line AS f
INNER JOIN chinook.chinook_mart.dim_date AS d
  ON f.date_key = d.date_key
WHERE d.date >= '2024-01-01'
  AND d.date <= '2025-12-31'
GROUP BY 
  DATE_TRUNC('month', d.date),
  d.year,
  d.month_name,
  d.month_and_year,
  d.month                      
ORDER BY date_month ASC;
