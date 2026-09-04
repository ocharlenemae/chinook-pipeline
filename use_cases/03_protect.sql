-- Business Problem: How to improve employee performance in terms of sales? --
-- Analytical Problem: Which employees experienced a dip in sales performance for the past year? --
-- Measure + By: Sales by employee
-- Query Gold (fact_invoice_line and dim_employee)

WITH employee_sales AS (
    SELECT 
        e.employee_name,
        SUM(CASE WHEN YEAR(d.date) = 2025 THEN f.total_revenue ELSE 0 END) AS sales_2025,
        SUM(CASE WHEN YEAR(d.date) = 2024 THEN f.total_revenue ELSE 0 END) AS sales_2024
    FROM chinook.chinook_mart.dim_employee AS e
    LEFT JOIN chinook.chinook_mart.fact_invoice_line AS f
        ON e.employee_id = f.employee_id
    LEFT JOIN chinook.chinook_mart.dim_date AS d
        ON f.date_key = d.date_key
    GROUP BY e.employee_name
)
SELECT 
    employee_name,
    COALESCE(sales_2025, 0) AS sales_2025,
    COALESCE(sales_2024, 0) AS sales_2024,
    (COALESCE(sales_2025, 0) - COALESCE(sales_2024, 0)) AS sales_increase_or_dip
FROM employee_sales
ORDER BY sales_increase_or_dip ASC;