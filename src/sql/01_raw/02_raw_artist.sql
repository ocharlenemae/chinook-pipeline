-- ARTIST TABLE --
CREATE TABLE IF NOT EXISTS chinook.chinook_raw.artist AS
SELECT *
FROM read_files(
    '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/Artist.csv',
    format => 'csv',
    header => True,
    schema => 'ArtistId INT, Name STRING'
);
