--  MONTHLY SALES TREND --
-- Tracks monthly total invoice revenue over the 2-year window (Jan 2024 - Dec 2025). --
CREATE OR REPLACE TABLE chinook.chinook_visualization.monthly_sales_trend_mv AS
SELECT
  d.month_and_year AS date,
  ROUND(SUM(f.total_revenue), 2) AS total_revenue
FROM chinook.chinook_mart.fact_invoice_line AS f
INNER JOIN chinook.chinook_mart.dim_date AS d
  ON f.date_key = d.date_key
WHERE d.date >= '2024-01-01'
  AND d.date <= '2025-12-31'
GROUP BY d.month_and_year;
