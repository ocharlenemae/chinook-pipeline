-- PLAYLIST TABLE --
CREATE OR REPLACE TABLE chinook.chinook_clean.playlist AS
SELECT 
    -- Cleaned playlist table with trimmed titles
    CAST(PlaylistId AS INT) AS playlist_id,     -- Primary key
    TRIM(Name) AS playlist_name
FROM chinook.chinook_raw.playlist
WHERE PlaylistId IS NOT NULL;
