-- TRACK TABLE --
CREATE OR REPLACE TABLE chinook.chinook_clean.track AS
SELECT 
    -- Cleaned track catalog table with standardized strings and numeric types
    CAST(TrackId AS INT) AS track_id,    -- Primary key
    TRIM(Name) AS track_name,
    CAST(AlbumId AS INT) AS album_id,     -- Foreign key -> album_clean
    CAST(MediaTypeId AS INT) AS media_type_id,     -- Foreign key -> media_type_clean
    CAST(GenreId AS INT) AS genre_id,
    COALESCE(TRIM(Composer), 'Unknown') AS composer,
    CAST(Milliseconds AS INT) AS milliseconds,
    CAST(Bytes AS BIGINT) AS bytes,
    CAST(UnitPrice AS DECIMAL(10,2)) AS unit_price
FROM chinook.chinook_raw.track
WHERE TrackId IS NOT NULL;
