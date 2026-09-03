-- EMPLOYEE SALES PERFORMANCE --
-- Tracks sales employees who landed #1 in revenue per quarter --
CREATE OR REPLACE TABLE chinook.chinook_visualization.employee_quarterly_top_ranks AS
WITH quarterly_top AS (
    SELECT
        e.employee_id,                                              
        e.employee_name,                                            
        d.year_and_quarter,
        ROUND(SUM(f.total_revenue), 2) AS total_revenue,           
        ROW_NUMBER() OVER (                                        
            PARTITION BY d.year_and_quarter 
            ORDER BY SUM(f.total_revenue) DESC
        ) AS rank                                                    
    FROM chinook.chinook_mart.fact_invoice_line AS f
    INNER JOIN chinook.chinook_mart.dim_employee AS e 
        ON f.employee_id = e.employee_id      
    INNER JOIN chinook.chinook_mart.dim_date AS d 
        ON f.date_key = d.date_key
    GROUP BY 
        e.employee_id, 
        e.employee_name, 
        d.year_and_quarter                              
)
SELECT
    employee_id,                                                    
    employee_name,                                                  
    COUNT(year_and_quarter) AS quarters_as_top_performer,           
    SUM(total_revenue) AS total_lifetime_revenue                    
FROM quarterly_top
WHERE rank = 1                                                       
GROUP BY 
    employee_id, 
    employee_name                                                      
ORDER BY 
    quarters_as_top_performer DESC, 
    total_lifetime_revenue DESC; 
