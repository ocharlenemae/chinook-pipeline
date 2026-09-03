-- INVOICE TABLE --
CREATE TABLE IF NOT EXISTS chinook.chinook_raw.invoice AS
SELECT *
FROM read_files(
    '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/Invoice.csv',
    format => 'csv',
    header => True,
    schema => 'InvoiceId INT, CustomerId INT, InvoiceDate TIMESTAMP, BillingAddress STRING, BillingCity STRING, BillingState STRING, BillingCountry STRING, BillingPostalCode STRING, Total DOUBLE'
);
