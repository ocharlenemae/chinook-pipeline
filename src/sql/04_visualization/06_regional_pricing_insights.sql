-- REGIONAL PRICING INSIGHTS --
-- Calculates average track unit price per country and state --
CREATE OR REPLACE TABLE chinook.chinook_visualization.regional_pricing_insights AS
SELECT 
  c.country,
  c.state,
  ROUND(AVG(f.unit_price), 2) AS avg_unit_price
FROM chinook.chinook_mart.fact_invoice_line AS f
INNER JOIN chinook.chinook_mart.dim_customer AS c
  ON f.customer_id = c.customer_id
GROUP BY c.country, c.state
ORDER BY avg_unit_price DESC;
