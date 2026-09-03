-- POPULAR TRACKS BY QUANTITY SOLD --
-- Retrieves the top 20 selling tracks along with album and artist info --
CREATE OR REPALCE TABLE chinook.chinook_visualization.popular_tracks_by_quantity_sold AS
SELECT
    t.track_id,
    t.track_name AS track,
    t.album_title AS album,
    t.artist_name AS artist,
    SUM(f.quantity) AS total_quantity_sold
FROM chinook.chinook_mart.fact_invoice_line AS f
INNER JOIN chinook.chinook_mart.dim_track AS t 
    ON f.track_id = t.track_id
GROUP BY t.track_id, track, album, artist
ORDER BY total_quantity_sold DESC
LIMIT 20;
