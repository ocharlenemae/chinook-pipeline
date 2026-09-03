-- INVOICE LINE TABLE --
CREATE OR REPLACE TABLE IF EXISTS chinook.chinook_clean.invoice_line AS
SELECT 
    -- Cleaned invoice line table with calculated line item amounts
    CAST(InvoiceLineId AS INT) AS invoice_line_id,     -- Primary key
    CAST(InvoiceId AS INT) AS invoice_id,     -- Foreign key -> invoice_clean
    CAST(TrackId AS INT) AS track_id,     -- Foreign key -> track_clean
    CAST(UnitPrice AS DECIMAL(10,2)) AS unit_price,
    CAST(Quantity AS INT) AS quantity,
    CAST((UnitPrice * Quantity) AS DECIMAL(10,2)) AS line_amount
FROM chinook.chinook_raw.invoice_line
WHERE InvoiceLineId IS NOT NULL;
