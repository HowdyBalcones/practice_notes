--MyContainerElement.applescript
--An InDesign AppleScript
--
--Provide example fragment for XMLRulesTable script.
tell application "Adobe InDesign 2024"
set myRowTag to xml tag "Row" of document 1
set myColumnTag to xml tag "Column" of document 1
--<fragment>
tell myContainerElement
	set myTable to convert to table row tag myRowTag cell tag myColumnTag
end tell
--</fragment>
end tell
