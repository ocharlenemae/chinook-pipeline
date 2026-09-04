-- Business Problem: How do we increase revenue in low-customer-base countries? --
-- Analytical Problem: Which countries have low customers? --
-- Measure + By: Revenue and active customer count by country
-- Query Gold (fact_invoice_line and dim_customer)

SELECT 
    c.country, 
    COUNT(DISTINCT f.customer_id) AS active_customer, 
    SUM(f.unit_price) AS revenue
FROM chinook.chinook_mart.dim_customer AS c
LEFT JOIN chinook.chinook_mart.fact_invoice_line AS f
    ON c.customer_id = f.customer_id
GROUP BY c.country
ORDER BY revenue ASC;