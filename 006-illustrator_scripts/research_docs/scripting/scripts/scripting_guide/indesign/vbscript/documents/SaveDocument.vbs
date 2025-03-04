Rem SaveDocument.vbs
Rem An InDesign VBScript
Rem
Rem If the document has been changed since it was last saved, save it.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
	myInDesign.Documents.Add
End Function
Function mySnippet(myInDesign)
	Rem ![Save a document.]
	Set myDocument = myInDesign.Documents.Item(1)
	Rem If the document has been changed since it was last saved, save it.
	Rem If the file is untitled, InDesign will display the Save dialog box.
	If myDocumentSaved = False Then
		myDocument.Save
	End If
	Rem ![Save a document.]
End Function
Function myTeardown(myInDesign)
End Function