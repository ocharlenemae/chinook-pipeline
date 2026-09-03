-- CUSTOMER TABLE --
CREATE OR REPLACE TABLE chinook.chinook_clean.customer AS
SELECT 
    -- Cleaned customer records with standardized contact information and normalized addresses
    CAST(CustomerId AS INT) AS customer_id,     -- Primary key 
    CONCAT(TRIM(FirstName), ' ', TRIM(LastName)) AS customer_name,     -- Full name concatenated from
    COALESCE(TRIM(Company), 'Unknown') AS company,
    REGEXP_REPLACE(Address, '[.,]', '') AS customer_address,
    TRIM(City) AS customer_city,
    COALESCE(TRIM(State), 'Unknown') AS company, AS customer_state,
    TRIM(Country) AS customer_country,
    COALESCE(UPPER(TRIM(PostalCode)), 'Unknown') AS customer_postal_code,
    CONCAT('+', REGEXP_REPLACE(Phone, '[^0-9]', '')) AS customer_phone,
    COALESCE(CONCAT('+', REGEXP_REPLACE(Fax, '[^0-9]', '')), 'Unknown') AS customer_fax,
    TRIM(Email) AS customer_email,
    CAST(SupportRepId AS INT) AS support_rep_id     -- Foreign key -> employee_clean
FROM chinook.chinook_raw.customer
WHERE CustomerId IS NOT NULL;
