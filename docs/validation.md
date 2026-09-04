# Data Quality & Hygiene Policies

# Validation & Data Quality
Data quality is enforced across a dual-layered framework. Applying data hygiene policies in the Silver layer prevents bad or malformed records from corrupting downstream dimensional models. Complementing this, business rule checks in the Gold layer enforce dimensional model integrity, verify key relationships, and ensure analytical metrics remain mathematically sound following transformation.

---

## Data Hygiene (Silver Layer)
- Convert raw text into correct physical formats (e.g., text timestamps to `Date`, numeric strings to `Integer`).
- Strip leading/trailing whitespace, remove invalid characters, and enforce consistent casing (`UPPERCASE` or `INITCAP`).
- Confirm numbers make business sense by filtering out invalid values like *zero or negative prices*, *negative quantities*, or *future transaction dates*.
- Replace `NULL` values in non-critical descriptive fields with a standard default marker (`'Unknown'`).
- Enforce strict non-null checks on essential primary and foreign keys (`customer_id`, `artist_id`, `track_id`, etc.).

## Business Rule Checks (Gold Layer)
- Run `LEFT JOIN` checks between *fact* and *dimension* tables to identify unmapped foreign keys.
- Ensure primary keys in dimension tables are strictly unique (`COUNT(DISTINCT key) == COUNT(key)`).
- Compare *total revenue* and *row counts* between Silver and Gold tables to prove zero data was accidentally lost during modeling.

---

## Data Quality Audit Queries

### Referential Integrity
Checks if any transaction in `fact_invoice_line` fails to map to a dimension table. Returns individual rows with boolean flags indicating which foreign key failed.

```sql
SELECT 
  f.invoice_line_id,
  f.invoice_id,
  f.track_id,
  f.customer_id,
  f.employee_id,
  f.date_key,
  (t.track_id IS NULL)    AS is_missing_track,
  (c.customer_id IS NULL) AS is_missing_customer,
  (e.employee_id IS NULL) AS is_missing_employee,
  (d.date_key IS NULL)    AS is_missing_date
FROM chinook.chinook_mart.fact_invoice_line AS f
LEFT JOIN chinook.chinook_mart.dim_track AS t 
  ON f.track_id = t.track_id
LEFT JOIN chinook.chinook_mart.dim_customer AS c 
  ON f.customer_id = c.customer_id
LEFT JOIN chinook.chinook_mart.dim_employee AS e 
  ON f.employee_id = e.employee_id
LEFT JOIN chinook.chinook_mart.dim_date AS d 
  ON f.date_key = d.date_key
WHERE t.track_id IS NULL
   OR c.customer_id IS NULL
   OR e.employee_id IS NULL
   OR d.date_key IS NULL;
```

### Dimension Uniqueness & Null Primary Keys 
Ensures all primary keys in dimension tables are strictly 100% unique and non-null.
```sql
-- Track Dimension PK Check
SELECT 
  'chinook.chinook_mart.dim_track' AS table_name,
  track_id AS primary_key,
  COUNT(*) AS key_count
FROM ftw.chinook.dim_track
GROUP BY track_id
HAVING COUNT(*) > 1 OR track_id IS NULL

UNION ALL

-- Customer Dimension PK Check
SELECT 
  'chinook.chinook_mart.dim_customer' AS table_name,
  customer_id AS primary_key,
  COUNT(*) AS key_count
FROM ftw.chinook.dim_customer
GROUP BY customer_id
HAVING COUNT(*) > 1 OR customer_id IS NULL

UNION ALL

-- Employee Dimension PK Check
SELECT 
  'chinook.chinook_mart.dim_employee' AS table_name,
  employee_id AS primary_key,
  COUNT(*) AS key_count
FROM ftw.chinook.dim_employee
GROUP BY employee_id
HAVING COUNT(*) > 1 OR employee_id IS NULL

UNION ALL

-- Date Dimension PK Check
SELECT 
  'chinook.chinook_mart.dim_date' AS table_name,
  date_key AS primary_key,
  COUNT(*) AS key_count
FROM ftw.chinook.dim_date
GROUP BY date_key
HAVING COUNT(*) > 1 OR date_key IS NULL;
```

### CROSS-LAYER METRIC RECONCILIATION
Compares total revenue and record counts between the cleaned Silver layer (`chinook_clean.invoice_line`) and the Gold layer (`chinook_mart.fact_invoice_line`) to detect data loss.

```sql
WITH silver_metrics AS (
  SELECT 
    ROUND(SUM(line_amount), 2) AS silver_total_revenue,
    COUNT(invoice_line_id) AS silver_line_count
  FROM chinook.chinook_clean.invoice_line
),
gold_metrics AS (
  SELECT 
    ROUND(SUM(total_revenue), 2) AS gold_total_revenue,
    COUNT(invoice_line_id) AS gold_line_count
  FROM chinook.chinook_clean.fact_invoice_line
)
SELECT 
  s.silver_total_revenue,
  g.gold_total_revenue,
  (s.silver_total_revenue - g.gold_total_revenue) AS revenue_difference,
  s.silver_line_count,
  g.gold_line_count,
  (s.silver_line_count - g.gold_line_count) AS count_difference,
  CASE 
    WHEN s.silver_total_revenue = g.gold_total_revenue 
     AND s.silver_line_count = g.gold_line_count 
    THEN 'PASSED' 
    ELSE 'FAILED' 
  END AS reconciliation_status
FROM silver_metrics AS s
CROSS JOIN gold_metrics AS g;
```