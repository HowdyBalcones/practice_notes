Rem FontCollections.vbs
Rem An InCopy VBScript
Rem
Rem Shows the difference between the fonts collection of the application
Rem and the fonts collection of a document.
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
	Set myApplicationFonts = myInCopy.Fonts
	Set myDocument = myInCopy.Documents.Add
	Set myStory = myDocument.Stories.Item(1)
	myString = "Document Fonts:" & vbCr
	For myCounter = 1 To myDocument.Fonts.Count
		myString = myString & myDocument.Fonts.Item(myCounter).Name & vbCr
	Next
	myString = myString & vbCr & "Application Fonts:" & vbCr
	For myCounter = 1 To myInCopy.Fonts.Count
		myString = myString & myInCopy.Fonts.Item(myCounter) & vbCr
	Next
	myStory.Contents = myString
End Function
Function myTeardown(myInCopy)
End Function

