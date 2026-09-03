-- CUSTOMER TABLE --
CREATE TABLE IF NOT EXISTS chinook.chinook_raw.customer AS
SELECT *
FROM read_files(
    '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/Customer.csv',
    format => 'csv',
    header => True,
    schema => 'CustomerId INT, FirstName STRING, LastName STRING, Company STRING, Address STRING, City STRING, State STRING, Country STRING, PostalCode STRING, Phone STRING, Fax STRING, Email STRING, SupportRepId INT'
);
