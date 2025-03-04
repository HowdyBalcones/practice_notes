--LayoutContextMenuLabelGraphic.applescript
--An InDesign AppleScript
--
--Shows how to add an interactive menu element to the layout context menu
--(the context menu that appears when you have an object selected).
--
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set number of sides of polygon preferences to 5
		set inset percentage of polygon preferences to 50
		--Create an example document.
		set myDocument to make document
		tell myDocument
			tell view preferences
				set horizontal measurement units to points
				set vertical measurement units to points
				set ruler origin to page origin
			end tell
			tell document preferences
				set page width to 294
				set page height to 286.658
			end tell
			tell metadata preferences
				set author to "Adobe Systems"
				set description to "This is a sample PDF with XMP metadata."
			end tell
			tell page 1
				set myPolygon to make polygon with properties {geometric bounds:{72, 72, 214.658, 222}}
				tell myPolygon
					--You'll have to fill in your own file path.
					export format PDF type to "yukino:test.pdf" without showing options
				end tell
			end tell
		end tell
		close myDocument saving no
		set myDocument to make document
		tell page 1 of myDocument
			--You'll have to fill in your own file path.
			place "yukino:test.pdf"
		end tell
	end tell
end mySetup
--Now that you've set up an example document containing s
--graphic, the snippet adds a menu choice to the Layout
--context menu. After you run the snippet, select the graphic with the
--Selection tool, then display the Layout context menu. You'll see the 
--"Create Graphic Label" menu option appear on the context menu. 
--When you select this menu item, InDesign will display a dialog
--containing options for adding a text frame near the graphic.
--end setup help text
on mySnippet()
	tell application "Adobe InDesign 2024"
		--<fragment>
		--The locale-independent name (aka "key string") for the 
		--Layout context menu is "$ID/RtMouseLayout".
		set myLayoutContextMenu to menu "$ID/RtMouseLayout"
		set myActionName to "Create Graphic Label"
		--Note that the following script actions only create the script menu action
		--and set up event listeners--they do not actually add the menu item to the
		--Layout context menu. That job is taken care of by the event handler scripts
		--themselves. The Layout context menu will not display the menu item unless
		--a graphic is selected.
		tell myLayoutContextMenu
			set myBeforeDisplayListener to make event listener with properties {event type:"beforeDisplay", handler:"yukino:IDEventHandlers:BeforeDisplayHandler.applescript", captures:false}
		end tell
		--</fragment>
	end tell
end mySnippet
on myTeardown()
end myTeardown
