-- ALBUM TABLE --
CREATE OR REPLACE TABLE chinook.chinook_clean.album AS
SELECT
    -- Clean the album table with trimmed strings and enforced data types
    CAST(AlbumId AS INT) AS album_id,     -- Primary key
    TRIM(Title) AS album_title,     
    CAST(ArtistId AS INT) AS artist_id     -- Foreign key -> artist_clean
FROM chinook.chinook_raw.album
WHERE AlbumId IS NOT NULL;
