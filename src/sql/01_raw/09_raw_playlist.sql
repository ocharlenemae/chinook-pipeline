-- PLAYLIST TABLE --
CREATE TABLE IF NOT EXISTS chinook.chinook_raw.playlist AS
SELECT *
FROM read_files(
    '/Volumes/ftw/chinook/ftw-b12-de/shared/week05/chinook_csv/Playlist.csv',
    format => 'csv',
    header => True,
    schema => 'PlaylistId INT, Name STRING'
);
