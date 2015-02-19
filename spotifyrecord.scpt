-- Code By Adamxp12.com - Tech Blog
-- Version 1.2
-- TODO: Record whole playlist without the adverts
--
tell application "Spotify"
	set theduration to duration of the current track
	set pos to player position as integer
	set timetostop to theduration - 4
	set trackName to name of current track
	set trackArtist to artist of current track
	set trackAlbum to album of current track
	pause
	
end tell


tell application "Audio Hijack Pro"
	set theSession to the first session whose name contains "Spotify"
	tell theSession
		set output name format to "%tag_title -- %tag_artist"
		
		set title tag to trackName
		set artist tag to trackArtist
		set album tag to trackAlbum
	end tell
	tell theSession to start hijacking
	tell theSession to start recording
end tell
tell application "Spotify"
	set player position to 0
	delay 1
	play
end tell
repeat
	tell application "Spotify"
		set theduration to duration of the current track
		set pos to player position as integer
		set timetostop to theduration - 3
		
		if pos ≥ timetostop then
			pause
			set player position to 0
		end if
	end tell
	
	tell application "Audio Hijack Pro"
		if pos ≥ timetostop then
			set theSession to the first session whose name contains "Spotify"
			tell theSession to stop hijacking
			tell theSession to stop recording
			error number -128
		end if
	end tell
	pos
	delay 1
end repeat
