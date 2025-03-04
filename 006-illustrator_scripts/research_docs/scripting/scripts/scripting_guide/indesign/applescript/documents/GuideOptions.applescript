--GuideOptions.applescript
--An InDesign AppleScript
--
--Shows how to set guide options.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		make document
	end tell
end mySetup
on mySnippet()
	--Shows how to set guide options.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Guide options.]
		--Given a document "myDocument"...
		tell myDocument
			set myPage to page 1
			--Create a layer named "guide layer".
			set myLayer to make layer with properties {name:"guide layer"}
			--Add a series of guides to page 1.
			tell myPage
				--Create a guide on the layer we created above.
				make guide with properties {orientation:horizontal, location:"12p", item layer:myLayer}
				make guide with properties {item layer:myLayer, orientation:horizontal, location:"14p"}
				--Make a locked guide.
				make guide with properties {locked:true, orientation:horizontal, location:"16p"}
				--Set the view threshold of a guide.
				make guide with properties {view threshold:100, orientation:horizontal, location:"18p"}
				--Set the guide color of a guide using a UIColors constant.
				make guide with properties {guide color:gray, orientation:horizontal, location:"20p"}
				--Set the guide color of a guide using an RGB array.
				make guide with properties {guide color:{192, 192, 192}, orientation:horizontal, location:"22p"}
			end tell
		end tell
		--![Guide options.]
	end tell
end mySnippet
to myTeardown()
end myTeardown
