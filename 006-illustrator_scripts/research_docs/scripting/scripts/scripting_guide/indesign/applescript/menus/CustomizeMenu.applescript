--CustomizeMenu.applescript
--An InDesign AppleScript
--
--Shows how to add a menu based on an existing menu action.
--Note that you might have to force InDesign to redraw the menu
--(by switching out of the application and back again) to make
--the menu item appear on the main menu bar.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Customize menu.]
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
		--![Customize menu.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
