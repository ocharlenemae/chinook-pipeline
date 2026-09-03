-- GENRE TABLE --
CREATE TABLE IF NOT EXISTS chinook.chinook_raw.genre AS
SELECT *
FROM read_files(
    '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/Genre.csv',
    format => 'csv',
    header => True,
    schema => 'GenreId INT, Name STRING'
);
