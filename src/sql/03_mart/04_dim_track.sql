-- TRACK DIMENSION --
CREATE OR REPLACE TABLE chinook.chinook_mart.dim_track AS
SELECT 
  t.track_id,
  t.track_name,
  al.album_title,
  a.artist_name,
  g.genre_name,
  mt.media_type_name
FROM chinook.chinook_clean.track AS t
LEFT JOIN chinook.chinook_clean.album AS al 
    ON t.album_id = al.album_id
LEFT JOIN chinook.chinook_clean.artist AS a
    ON al.artist_id = a.artist_id
LEFT JOIN chinook.chinook_clean.genre AS g 
    ON t.genre_id = g.genre_id
LEFT JOIN chinook.chinook_clean.media_type AS mt 
    ON t.media_type_id = mt.media_type_id;
