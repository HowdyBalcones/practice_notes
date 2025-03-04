Rem PageSelect.vbs
Rem An InDesign VBScript
Rem
Rem Select pages.

main

Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function

Function mySetup(myInDesign)
	Rem Create a new document.
	Set myDocument = myInDesign.Documents.Add()
	Rem Create another 3 pages.
	Set myPages = myDocument.Pages
	For i = 2 To 4
		myPages.Add()
	Next
End Function

Function mySnippet(myInDesign)
	Rem ![Select page.]
	Rem Given a document with four pages (1, 2, 3, 4)...
	Set myDocument = myInDesign.ActiveDocument
	Set myPages = myDocument.Pages
	Rem Select page 2 and 3.
	myPages.Item(2).Select()
	myPages.Item(3).select(idSelectionOptions.idAddTo)
	Rem Select last page.
	Call myDocument.Select(myPages.Item(-1), idSelectionOptions.idAddTo)
	Rem ![Select page.]
End Function

Function myTeardown(myInDesign)
End Function
