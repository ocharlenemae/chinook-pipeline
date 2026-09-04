-- Business Problem: How to increase demand/sales for the lowest-performing artists? --
-- Analytical Problem: Which artist has the lowest sales? --
-- Measure + By: Sales by artist
-- Query Gold (fact_invoice_line and dim_track)

SELECT 
    t.artist_name, 
    SUM(f.total_revenue) AS sales
FROM chinook.chinook_mart.fact_invoice_line AS f
LEFT JOIN chinook.chinook_mart.dim_track AS t
    ON t.track_id = f.track_id
GROUP BY t.artist_name
ORDER BY sales ASC;