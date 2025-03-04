--RemoveCustomMenu.applescript
--An InDesign AppleScript
--
--Shows how to remove the submenu and menu items created
--by the CustomizeMenu.applescript tutorial script.
--Note that you might have to force InDesign to redraw the menu
--(by switching out of the application and back again) to make
--the menu item appear on the main menu bar.
tell application "Adobe InDesign 2024"
	--![Remove custom menu.]
	set myMainMenu to menu "Main"
	try
		set myKozukaMenu to submenu "Kozuka Mincho Pro" of myMainMenu
		tell myKozukaMenu to delete
	end try
	--![Remove custom menu.]
end tell
