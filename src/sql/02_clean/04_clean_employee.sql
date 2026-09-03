-- EMPLOYEE TABLE --
CREATE OR REPLACE TABLE IF NOT EXISTS chinook.chinook_clean.employee AS
SELECT 
    -- Cleaned employee directory with formatted dates, addresses, and phone numbers
    CAST(EmployeeId AS INT) AS employee_id,     -- Primary key
    CONCAT(TRIM(FirstName), ' ', TRIM(LastName)) AS employee_name,
    TRIM(Title) AS title,
    CAST(ReportsTo AS INT) AS reports_to,     -- Self-referencing foreign key -> employee_clean
    CAST(BirthDate AS DATE) AS birth_date,
    CAST(HireDate AS DATE) AS hire_date,
    REGEXP_REPLACE(Address, '[.,]', '') AS employee_address,
    TRIM(City) AS employee_city,
    TRIM(State) AS employee_state,
    TRIM(Country) AS employee_country,
    UPPER(TRIM(PostalCode)) AS employee_postal_code,
    CONCAT('+', REGEXP_REPLACE(Phone, '[^0-9]', '')) AS employee_phone,
    CONCAT('+', REGEXP_REPLACE(Fax, '[^0-9]', '')) AS employee_fax,
    TRIM(Email) AS employee_email
FROM chinook.chinook_raw.employee
WHERE EmployeeId IS NOT NULL;
