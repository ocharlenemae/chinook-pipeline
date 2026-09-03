-- TOP REVENUE BY GENRE PER COUNTRY -- 
-- Identify the top revenue-generating genres per country. --
CREATE OR REPLACE TABLE chinook.chinook_visualization.top_genre_by_country_mv AS
WITH ranked_genres AS (
    SELECT
        c.country,                                                 
        t.genre_name AS genre,                                     
        ROUND(SUM(f.total_revenue), 2) AS total_revenue,          
        DENSE_RANK() OVER (                                        
            PARTITION BY c.country 
            ORDER BY SUM(f.total_revenue) DESC
        ) AS genre_rank
    FROM chinook.chinook_mart.fact_invoice_line AS f
    INNER JOIN chinook.chinook_mart.dim_customer AS c 
        ON f.customer_id = c.customer_id     
    INNER JOIN chinook.chinook_mart.dim_track AS t 
        ON f.track_id = t.track_id
    GROUP BY 
        c.country, 
        genre                                                
)
SELECT *                                                           
FROM ranked_genres 
WHERE genre_rank <= 3                                              
ORDER BY 
    country, 
    genre_rank;
