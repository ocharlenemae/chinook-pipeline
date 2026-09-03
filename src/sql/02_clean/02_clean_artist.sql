-- ARTIST TABLE --
CREATE OR REPLACE TABLE chinook.chinook_clean.artist AS
SELECT 
    -- Cleaned artist table with trimmed names and unknown artist names
    CAST(ArtistId AS INT) AS artist_id,     -- Primary key
    COALESCE(TRIM(Name), 'Unknown') AS artist_name
FROM chinook.chinook_raw.artist
WHERE ArtistId IS NOT NULL;