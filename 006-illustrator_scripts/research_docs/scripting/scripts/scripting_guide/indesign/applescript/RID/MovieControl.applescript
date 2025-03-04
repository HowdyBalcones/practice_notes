--MovieControl.applescript
--An InDesign AppleScript
--
--Shows how to make a button to control movie playback.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
			set ruler origin to page origin
		end tell
		my myAddColor(myDocument, "Red", RGB, process, {255, 0, 0})
		my myAddColor(myDocument, "Gray", RGB, process, {200, 200, 200})
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		--![Movie control.]
		--Given a page "myPage" in a document "myDocument," 
		--containing the colors "Gray" and "Red"...
		tell myPage
			set myFrame to make rectangle with properties {geometric bounds:{72, 72, 288, 288}}
			--Import a movie file (you'll have to provide a valid file path on your system)
			tell myFrame to place file "hazuki:movie.mp4"
			--Create the movie "Start" button.
			set myPlayButton to make button with properties {geometric bounds:{294, 186, 354, 282}, name:"PlayMovieButton"}
			tell myPlayButton
				set myRightArrow to make polygon with properties {fill color:color "Gray" of myDocument, stroke color:"None"}
			end tell
			set entire path of path 1 of myRightArrow to {{186, 294}, {186, 354}, {282, 324}}
			--Add the Rollover state.
			tell myPlayButton
				set myRolloverState to make state
			end tell
			--Add a shadow to the polygon in the Rollover state.
			tell myRolloverState
				set myRolloverArrow to make polygon with properties {fill color:color "Gray" of myDocument, stroke color:"None"}
			end tell
			set entire path of path 1 of myRolloverArrow to {{186, 294}, {186, 354}, {282, 324}}
			tell drop shadow settings of fill transparency settings of myRolloverArrow
				set mode to drop
				set angle to 90
				set x offset to 0
				set y offset to 0
				set size to 6
			end tell
			tell myPlayButton
				set myClickState to make state
			end tell
			tell myClickState
				set myClickArrow to make polygon with properties {fill color:color "Red" of myDocument, stroke color:"None"}
			end tell
			set entire path of path 1 of myClickArrow to {{186, 294}, {186, 354}, {282, 324}}
			--Set the behavior for the button.
			tell myPlayButton
				set myMovieStartBehavior to make movie behavior with properties {movie item:movie 1 of myFrame, behavior event:mouse up, operation:play}
			end tell
			--Create the movie "Stop" button.
			set myStopButton to make button with properties {geometric bounds:{294, 78, 354, 174}, name:"StopMovieButton"}
			tell state 1 of myStopButton
				set myNormalRectangle to make rectangle with properties {geometric bounds:{294, 78, 354, 174}, fill color:color "Gray" of myDocument}
			end tell
			tell myStopButton
				set myRolloverState to make state
			end tell
			tell myRolloverState
				set myRolloverRectangle to make rectangle with properties {geometric bounds:{294, 78, 354, 174}, fill color:color "Gray" of myDocument}
			end tell
			tell drop shadow settings of fill transparency settings of myRolloverRectangle
				set mode to drop
				set angle to 90
				set x offset to 0
				set y offset to 0
				set size to 6
			end tell
			tell myStopButton
				set myClickState to make state
			end tell
			tell myClickState
				set myClickRectangle to make rectangle with properties {geometric bounds:{294, 78, 354, 174}, fill color:color "Red" of myDocument}
			end tell
			tell myStopButton
				set myMovieStopBehavior to make movie behavior with properties {movie item:movie 1 of myFrame, behavior event:mouse up, operation:stop}
			end tell
		end tell
		--![Movie control.]
	end tell
end mySnippet
on myTeardown()
end myTeardown

on myAddColor(myDocument, myColorName, myColorSpace, myColorModel, myColorValue)
	tell application "Adobe InDesign 2024"
		tell myDocument
			try
				set myColor to color myColorName
			on error
				set myColor to make color with properties {name:myColorName}
			end try
			set properties of myColor to {space:myColorSpace, model:myColorModel, color value:myColorValue}
			return myColor
		end tell
	end tell
end myAddColor
