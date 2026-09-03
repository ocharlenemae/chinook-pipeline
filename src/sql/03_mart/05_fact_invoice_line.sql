-- FACT INVOICE LINE TABLE --
CREATE OR REPLACE TABLE chinook.chinook_mart.fact_invoice_line AS
SELECT
  -- Primary Keys
  il.invoice_line_id,
  il.invoice_id,

  -- Foreign Keys (From Dimension Views)
  t.track_id,                                                                  
  c.customer_id,                                                                
  e.employee_id,                                                                
  d.date_key,                                                                  

  -- Pre-calculated Financial Metrics
  il.quantity,
  il.unit_price,
  il.line_amount AS total_revenue,

  -- Supplemental fields (also for filtering)
  t.artist_name,
  t.genre_name,
  c.country

FROM chinook.chinook_clean.invoice_line AS il
INNER JOIN chinook.chinook_clean.invoice AS i
  ON il.invoice_id = i.invoice_id
LEFT JOIN chinook.chinook_mart.dim_track LIVE.dim_track AS t
  ON il.track_id = t.track_id
LEFT JOIN chinook.chinook_mart.dim_customer AS c
  ON i.customer_id = c.customer_id
LEFT JOIN chinook.chinook_mart.dim_employee AS e
  ON c.support_rep_id = e.employee_id
LEFT JOIN chinook.chinook_mart.dim_date AS d
  ON i.invoice_date = d.date;
