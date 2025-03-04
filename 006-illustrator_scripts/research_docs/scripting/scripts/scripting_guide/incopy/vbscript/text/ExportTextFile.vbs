Rem ExportTextFile.vbs
Rem An InCopy VBScript
Rem
Rem Creates a story in an example document and then exports the text to a text file.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Rem Create a text frame on page 1.
	Set myStory = myDocument.Stories.Item(1)
	Rem Fill the text frame with placeholder text.
	myStory.TextContainers.Item(1).Contents = idTextFrameContents.idPlaceholderText
	Rem Text export method parameters:
	Rem Format as idExportFormat
	Rem To As File
	Rem [ShowingOptions As Boolean = False]
	Rem
	Rem Format parameter can be:
	Rem idExportFormat.idRTF
	Rem idExportFormat.idTaggedText
	Rem idExportFormat.idTextType
	Rem
	Rem Export the story as text. You'll have to fill in a valid file path on your system.
	myStory.Export idExportFormat.idTextType, "C:\test.txt"
End Function
Function myTeardown(myInCopy)
End Function

