Rem SpecialCharacters.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to enter special characters in text.
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
	Rem Entering special characters directly.
	myStory.Contents = "Registered trademark: �" & vbCr & "Copyright: �" & vbCr & "Trademark: �" & vbCr
	Rem Entering special characters by their Unicode glyph ID value:
	myStory.InsertionPoints.Item(-1).Contents = "Not equal to: <2260>" & vbCr
	myStory.InsertionPoints.Item(-1).Contents = "Square root: <221A>" & vbCr
	myStory.InsertionPoints.Item(-1).Contents = "Section symbol: <00B6>" & vbCr
	Rem Entering InDesign special characters by their enumerations:
	myStory.InsertionPoints.Item(-1).Contents = "Automatic page number marker:"
	myStory.InsertionPoints.Item(-1).Contents = idSpecialCharacters.idAutoPageNumber
	myStory.InsertionPoints.Item(-1).Contents = vbCr
	myStory.InsertionPoints.Item(-1).Contents = "Section symbol:"
	myStory.InsertionPoints.Item(-1).Contents = idSpecialCharacters.idSectionSymbol
	myStory.InsertionPoints.Item(-1).Contents = vbCr
	myStory.InsertionPoints.Item(-1).Contents = "En dash:"
	myStory.InsertionPoints.Item(-1).Contents = idSpecialCharacters.idEnDash
	myStory.InsertionPoints.Item(-1).Contents = vbCr
End Function
Function myTeardown(myInCopy)
End Function

