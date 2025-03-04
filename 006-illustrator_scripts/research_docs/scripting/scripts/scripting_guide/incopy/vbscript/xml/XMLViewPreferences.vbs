Rem XMLViewPreferences.vbs
Rem An InCopy VBScript
Rem
Rem Sets XML view preferences for a document.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	Set myXMLViewPreferences = myDocument.XMLViewPreferences
	myXMLViewPreferences.ShowAttributes = True
	myXMLViewPreferences.ShowStructure = True
	myXMLViewPreferences.ShowTaggedFrames = True
	myXMLViewPreferences.ShowTagMarkers = True
	myXMLViewPreferences.ShowTextSnippets = True
End Function
Function myTeardown(myInCopy)
End Function

