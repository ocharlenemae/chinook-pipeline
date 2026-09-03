-- ARTIST TABLE --
CREATE OR REPLACE TABLE chinook.chinook_clean.artist AS
SELECT 
    -- Cleaned artist table with trimmed names
    CAST(ArtistId AS INT) AS artist_id,     -- Primary key 
    TRIM(Name) AS artist_name     
FROM chinook.chinook_raw.artist
WHERE ArtistId IS NOT NULL;
