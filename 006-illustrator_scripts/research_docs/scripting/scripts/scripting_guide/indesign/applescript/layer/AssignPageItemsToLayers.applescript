--AssignPageItemsToLayers.applescript
--An InDesign AppleScript
--
--Shows how to create page items on a given layer
--and how to move existing page items to a layer.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell myDocument
			set horizontal measurement units of view preferences to points
			set vertical measurement units of view preferences to points
			make layer with properties {name:"Rectangles"}
			make layer with properties {name:"Ovals"}
			make layer with properties {name:"TextFrames"}
		end tell
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		set myPage to page 1 of myDocument
		--![Assign page items to layers.]
		--Given a reference to a page "myPage," and a document "myDocument"...
		tell myPage
			--Create a text frame on a layer named "TextFrames"
			set myTextFrame to make text frame with properties {itemLayer:layer "TextFrames", geometric bounds:{72, 72, 144, 144}}
			--Create a rectangle on the current target layer.
			set myRectangle to make rectangle with properties {geometric bounds:{72, 144, 144, 216}}
			--Move the rectangle to a specific layer.
			set item layer of myRectangle to layer "Rectangles" of myDocument
			--Create a series of ovals.
			repeat with myCounter from 72 to 172 by 10
				make oval with properties {geometric bounds:{216, myCounter, 226, myCounter + 10}}
			end repeat
			--Move all of the ovals on the page to a specific layer.
			repeat with myCounter from 1 to (count ovals)
				set item layer of oval myCounter to layer "Ovals" of myDocument
			end repeat
		end tell
		--![Assign page items to layers.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
