--ResolveLocation.applescript
--An InDesign AppleScript
--
--Shows how to use the resolve method.
main()
on main()
	my mySetup()
	my mySnippet()
	my myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Resolve location.]
		--Given a group on page 1 that contains a rectangle...
		set myRectangle to rectangle 1 of group 1 of page 1 of document 1
		--Template for resolve:
		--set theResult to resolve <reference>
		--location <anything> usually either an anchor point or a coordinate pair and an anchor point (as shown below)
		--in <coordinate system> usually either pasteboard coordinates or parent coordinates
		--considering ruler units <boolean> set to true if you have provided page coordinates (as shown below)
		--
		--Get ruler coordinate {72, 72} in pasteboard coordinates.
		set myPageLocation to resolve myRectangle location {{72, 72}, top right anchor} in pasteboard coordinates without considering ruler units
		--resolve returns a list containing a single item.
		set myPageLocation to item 1 of myPageLocation
		display dialog "Pasteboard Coordinates:" & return & return & "X: " & item 1 of myPageLocation & return & "Y: " & item 2 of myPageLocation
		--Get ruler coordinate {72, 72} in parent coordinates.
		set myPageLocation to resolve myRectangle location {{72, 72}, top right anchor} in parent coordinates without considering ruler units
		--resolve returns a list containing a single item.
		set myPageLocation to item 1 of myPageLocation
		display dialog "Parent Coordinates:" & return & return & "X: " & item 1 of myPageLocation & return & "Y: " & item 2 of myPageLocation
		--![Resolve location.]
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
		set when scaling of transform preferences to adjust scaling percentage
		set myTransformationMatrix to make transformation matrix with properties {counterclockwise rotation angle:45}
		set myDocument to make document
		tell myDocument
			set horizontal measurement units of view preferences to points
			set vertical measurement units of view preferences to points
			set myPageHeight to page height of document preferences
			set myPageWidth to page width of document preferences
			set myPageXCenter to myPageWidth / 2
			set myPageYCenter to myPageHeight / 2
			set zero point to {myPageXCenter, myPageYCenter}
			tell page 1
				make guide with properties {orientation:horizontal, location:0}
				make guide with properties {orientation:vertical, location:0}
				--Create a rectangle.
				set myRectangle to make rectangle with properties {geometric bounds:{-72, -72, 72, 72}}
				--Rotate the rectangle around its center point.
				transform myRectangle in pasteboard coordinates from center anchor with matrix myTransformationMatrix
				--Add a series of ovals.
				set myOvalA to make oval with properties {geometric bounds:{-84, -84, -60, -60}}
				set myOvalB to make oval with properties {geometric bounds:{84, -84, 60, -60}}
				set myOvalC to make oval with properties {geometric bounds:{-84, 84, -60, 60}}
				set myOvalD to make oval with properties {geometric bounds:{84, 84, 60, 60}}
				--Group the rectangle and the ovals.
				set myGroup to make group with properties {group items:{myRectangle, myOvalA, myOvalB, myOvalC, myOvalD}}
				--Rotate the group.
				transform myGroup in pasteboard coordinates from center anchor with matrix myTransformationMatrix
			end tell
		end tell
	end tell
end mySetup
on myTeardown()
end myTeardown
