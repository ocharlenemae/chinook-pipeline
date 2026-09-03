-- INVOICE TABLE --
CREATE OR REPLACE TABLE chinook.chinook_clean.invoice AS
SELECT 
    -- Cleaned invoice table with standardized timestamps, billing address, and totals
    CAST(InvoiceId AS INT) AS invoice_id,     -- Primary key
    CAST(CustomerId AS INT) AS customer_id,     -- Foreign key -> customer_clean
    CAST(InvoiceDate AS TIMESTAMP) AS invoice_timestamp,
    CAST(InvoiceDate AS DATE) AS invoice_date,
    REGEXP_REPLACE(BillingAddress, '[.,]', '') AS billing_address,
    TRIM(BillingCity) AS billing_city,
    COALESCE(TRIM(BillingState), 'Unknown') AS billing_state,
    TRIM(BillingCountry) AS billing_country,
    COALESCE(UPPER(TRIM(BillingPostalCode)), 'Unknown') AS billing_postal_code,
    CAST(Total AS DECIMAL(10,2)) AS total
FROM chinook.chinook_raw.invoice
WHERE InvoiceId IS NOT NULL;
