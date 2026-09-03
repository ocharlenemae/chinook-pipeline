-- GENRE TABLE --
CREATE OR REPLACE TABLE chinook.chinook_clean.genre AS
SELECT 
    -- Cleaned genre table with trimmed genre names
    CAST(GenreId AS INT) AS genre_id,     -- Primary key
    TRIM(Name) AS genre_name
FROM chinook.chinook_raw.genre
WHERE GenreId IS NOT NULL;
