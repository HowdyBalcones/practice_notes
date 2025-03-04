Rem PlaceTextFile.vbs
Rem An InCopy VBScript
Rem
Rem Places a text file in the default story of a new document.
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
	Rem Parameters for Place:
	Rem File as File object,
	Rem [ShowingOptions as Boolean = False]
	Rem You'll have to fill in a valid file path on your system.
	myDocument.Stories.Item(1).InsertionPoints.Item(1).Place "c:\test.txt", False
End Function
Function myTeardown(myInCopy)
End Function

