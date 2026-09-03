-- PLAYLIST TRACK TABLE --
CREATE OR REPLACE TABLE chinook.chinook_clean.playlist_track AS
SELECT
    -- Cleaned table mapping playlists to tracks 
    CAST(PlaylistId AS INT) AS playlist_id,    -- Foreign key -> playlist_clean
    CAST(TrackId AS INT) AS track_id     -- Foreign key -> track_clean
FROM chinook.chinook_raw.playlist_track
WHERE PlaylistId IS NOT NULL AND TrackId IS NOT NULL;
