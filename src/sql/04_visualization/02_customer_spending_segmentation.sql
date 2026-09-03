-- CUSTOMER SPENDING SEGMENTATION -- 
-- Categorizes customers into spending tiers (High: >$50, Medium: $20-$50, Low: <$20) and counts total customers per tier. --
CREATE OR REPLACE TABLE chinook.chinook_visualization.customer_spending_segmentation_mv AS
WITH customer_totals AS (
    SELECT
        customer_id,
        SUM(total_revenue) AS total_spend  
    FROM chinook.chinook_mart.fact_invoice_line
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN total_spend > 50 THEN 'High'
        WHEN total_spend >= 20 THEN 'Medium'
        ELSE 'Low'
    END AS spending_tier,
    COUNT(customer_id) AS customer_count    
FROM customer_totals
GROUP BY spending_tier;
