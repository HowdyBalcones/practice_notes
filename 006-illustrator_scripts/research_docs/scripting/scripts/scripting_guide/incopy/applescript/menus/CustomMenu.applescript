--CustomMenu.applescripttell application "Adobe InCopy 2024"
--An InCopy AppleScript
--
--Adds a custom menu to the main menu bar.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InCopy 2024"
		set myMainMenu to menu "Main"
		set myTypeMenu to submenu "Type" of myMainMenu
		set myFontMenu to submenu "Font" of myTypeMenu
		set myKozukaMenu to submenu "Kozuka Mincho Pro " of myFontMenu
		tell myMainMenu
			set mySpecialFontMenu to make submenu with properties {title:"Kozuka Mincho Pro"}
		end tell
		repeat with myMenuItem in menu items of myKozukaMenu
			set myAssociatedMenuAction to associated menu action of myMenuItem
			tell mySpecialFontMenu
				make menu item with properties {associated menu action:myAssociatedMenuAction}
			end tell
		end repeat
	end tell
end mySnippet
on myTeardown()
end myTeardown


