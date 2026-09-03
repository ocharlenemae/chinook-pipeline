-- EMPLOYEE TABLE --
CREATE TABLE IF NOT EXISTS chinook.chinook_raw.employee AS
SELECT *
FROM read_files(
    '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/Employee.csv',
    format => 'csv',
    header => True,
    schema => 'EmployeeId INT, LastName STRING, FirstName STRING, Title STRING, ReportsTo INT, BirthDate DATE, HireDate DATE, Address STRING, City STRING, State STRING, Country STRING, PostalCode STRING, Phone STRING, Fax STRING, Email STRING'
);
