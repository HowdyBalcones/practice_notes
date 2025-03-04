--ExportPDF.applescript
--An InDesign Server AppleScript
--Exports the current document as PDF.
--Assumes you have a document open.
--document.exportFile parameters are:
--format: use either the ExportFormat.pdfType constant or the string "Adobe PDF"
--to: a file path as a string
--using: PDF export preset (or a string that is the name of a PDF export preset)
--The default PDF export preset names are surrounded by square brackets (e.g., "[Screen]").
tell application "InDesignServer"
	if (count documents) is not equal to 0 then
		tell application "Finder"
			set myFile to (startup disk as string) & "ServerTestFiles:myTestDocument.pdf"
		end tell
		export document 1 format PDF type to myFile
	else
		set result to "No documents are open."
	end if
end tell
