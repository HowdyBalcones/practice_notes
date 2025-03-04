--ReorderArticleMembers.applescript
--An InDesign AppleScript
--
--Shows how to reorder members in an article.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		--Set the measurement units to points
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
		
		set myPage to page 1 of myDocument
		tell myPage
			make rectangle with properties {geometric bounds:{72, 72, 144, 144}}
			make oval with properties {geometric bounds:{156, 72, 228, 144}}
			make rectangle with properties {geometric bounds:{250, 72, 322, 144}}
			make oval with properties {geometric bounds:{334, 72, 406, 144}}
			
			make text frame with properties {geometric bounds:{418, 72, 490, 144}, contents:"Text Frame"}
			
			make group with properties {group items:{rectangle 1, oval 1}}
		end tell
	end tell
	
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		
		tell myDocument	
			set article1 to make article with properties {name:"Article1"}
			set myPage to page 1
			tell article1
				--![Reorder article members.]
				make article member with properties {item ref:rectangle 1 of myPage}
				make article member with properties {item ref:oval 1 of myPage}
				make article member with properties {item ref:text frame 1 of myPage}
				make article member with properties {item ref:group 1 of myPage}
				
				move article member 1 to end of article member 0
				move article member 3 to beginning of article member 0
				move article member 2 to after article member 3
				--![Reorder article members.]
			end tell
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown