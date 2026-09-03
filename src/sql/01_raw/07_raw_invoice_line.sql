-- INVOICE LINE TABLE --
CREATE TABLE IF NOT EXISTS chinook.chinook_raw.invoice_line AS
SELECT *
FROM read_files(
    '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/InvoiceLine.csv',
    format => 'csv',
    header => True,
    schema => 'InvoiceLineId INT, InvoiceId INT, TrackId INT, UnitPrice DOUBLE, Quantity INT'
);
