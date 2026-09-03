-- MEDIA TYPE TABLE --
CREATE TABLE IF NOT EXISTS chinook.chinook_raw.media_type AS
SELECT *
FROM read_files(
    '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/MediaType.csv',
    format => 'csv',
    header => True,
    schema => 'MediaTypeId INT, Name STRING'
);
