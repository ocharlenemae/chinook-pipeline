-- ALBUM TABLE --
CREATE TABLE IF NOT EXISTS chinook.chinook_album AS
SELECT *
FROM read_files(
    '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/Album.csv',
    format => 'csv',
    header => True,
    schema => 'AlbumId INT, Title STRING, ArtistId INT'
);
