--AddRemoveArticleMember.applescript
--An InDesign AppleScript
--
--Shows how to add members to an article and how to remove 
--members from an article.
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
			make oval with properties {geometric bounds:{72, 156, 144, 228}}
			make oval with properties {geometric bounds:{156, 72, 228, 144}}
			make rectangle with properties {geometric bounds:{156, 156, 228, 228}}
			
			set rectangle1 to make rectangle with properties {geometric bounds:{250, 72, 322, 144}}
			set oval1 to make oval with properties {geometric bounds:{250, 156, 322, 228}}
			set rectangle2 to make rectangle with properties {geometric bounds:{334, 72, 406, 144}}
			set oval2 to make oval with properties {geometric bounds:{334, 157, 406, 228}}
			
			make group with properties {group items:{rectangle1, oval1, rectangle2, oval2}}
		end tell
	end tell
	
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Add article member.]
		set myDocument to document 1
		tell myDocument
			set article1 to make article with properties {name:"Article1"}
			set article2 to make article with properties {name:"Article2"}
			set article3 to make article with properties {name:"Article3"}
			
			set myPage to page 1 of myDocument
			--set article4 to make article with properties {article member:{rectangle 1 of myPage, oval 1 of myPage}}
			
			--add rectangle 1 of myPage to article1
			tell article1
				make article member with properties {item ref:rectangle 1 of myPage}
				make article member with properties {item ref:oval 1 of myPage}
			end tell
			
			tell article2
				make article member with properties {item ref:rectangle 2 of myPage}
				make article member with properties {item ref:oval 2 of myPage}
			end tell
			
			tell article3
				make article member with properties {item ref:group 1 of myPage}
			end tell
			--![Add article member.]
			
			--![Remove article member.]
			tell article member 1 of article1 to delete
			--![Remove article member.]
		end tell
	end tell
end mySnippet
on myTeardown()
end myTeardown