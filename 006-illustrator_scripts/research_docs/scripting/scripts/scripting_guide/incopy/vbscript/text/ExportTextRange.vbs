Rem ExportTextRange.vbs
Rem An InCopy VBScript
Rem
Rem Creates a story in an example document and then exports
Rem some of the text to a text file.
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
	Set myStory = myDocument.Stories.Item(1)
	Set myTextFrame = myStory.TextContainers.Item(1)
	Rem Fill the text frame with placeholder text.
	myTextFrame.Contents = idTextFrameContents.idPlaceholderText
	Set myStartCharacter = myStory.Paragraphs.Item(1).Characters.Item(1)
	Set myEndCharacter = myStory.Paragraphs.Item(1).Characters.Item(-1)
	Set myText = myStory.Texts.ItemByRange(myStartCharacter, myEndCharacter).Item(1)
	Rem Text export method parameters:
	Rem Format as idExportFormat
	Rem To As File
	Rem [ShowingOptions As Boolean = False]
	Rem
	Rem Format parameter can be:
	Rem idExportFormat.idInCopyDocument
	Rem idExportFormat.idInCopyCSDocument
	Rem idExportFormat.idRTF
	Rem idExportFormat.idTaggedText
	Rem idExportFormat.idTextType
	Rem
	Rem Export the text range. You'll have to fill in a valid file path on your system.
	myText.Export idExportFormat.idTextType, "C:\test.txt"
End Function
Function myTeardown(myInCopy)
End Function