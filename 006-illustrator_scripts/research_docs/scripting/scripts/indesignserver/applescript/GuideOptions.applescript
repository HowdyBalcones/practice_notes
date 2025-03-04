--GuideOptions.applescript
--An InDesign Server AppleScript
--Shows how to set guide options.
tell application "InDesignServer"
	set myDocument to make document
	--Create a layer named "guide layer".
	try
		set myLayer to layer "guide layer" of myDocument
	on error
		tell myDocument
			set myLayer to make layer with properties {name:"guide layer"}
		end tell
	end try
	--Add a series of guides to page 1.
	tell page 1 of myDocument
		--Create a guide on the layer we created above.
		make guide with properties {orientation:horizontal, location:"12p", item layer:myLayer}
		--Make a locked guide.
		make guide with properties {orientation:horizontal, location:"16p", locked:true}
		--Set the view threshold of a guide.
		make guide with properties {orientation:horizontal, location:"20p", item layer:myLayer, view threshold:100}
		--Set the guide color of a guide using a UIColors constant.
		make guide with properties {orientation:horizontal, location:"24p", item layer:myLayer, guide color:gray}
		--Set the guide color of a guide using an RGB array.
		make guide with properties {orientation:horizontal, location:"28p", item layer:myLayer, guide color:{192, 192, 192}}
	end tell
	--Save the file (fill in a valid file path on your system).
	tell application "Finder"
		set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.indd"
	end tell
	set myDocument to save myDocument to myFile
	--Close the document
	close myDocument
end tell
