-- TRACK TABLE --
CREATE TABLE IF NOT EXISTS chinook.chinook_raw.track AS
SELECT *
FROM read_files(
    '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/Track.csv',
    format => 'csv',
    header => True,
    schema => 'TrackId INT, Name STRING, AlbumId INT, MediaTypeId INT, GenreId INT, Composer STRING, Milliseconds INT, Bytes BIGINT, UnitPrice DOUBLE'
);
