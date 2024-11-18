SELECT 
	playlists.PlaylistId,
	playlist_track.PlaylistId,
	playlist_track.TrackId,
	COUNT(playlist_track.TrackId) AS "Total Tracks" 
FROM playlists
JOIN playlist_track
	ON playlists.PlaylistId
	= playlist_track.PlaylistId
GROUP BY TrackId
ORDER BY "Total Tracks" DESC;