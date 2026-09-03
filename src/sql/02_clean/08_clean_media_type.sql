-- MEDIA TYPE TABLE --
CREATE OR REPLACE TABLE IF EXISTS chinook.chinook_clean.media_type AS
SELECT 
    -- Cleaned media format lookup table
    CAST(MediaTypeId AS INT) AS media_type_id,     -- Primary key
    TRIM(Name) AS media_type_name
FROM chinook.chinook_raw.media_type
WHERE MediaTypeId IS NOT NULL;
