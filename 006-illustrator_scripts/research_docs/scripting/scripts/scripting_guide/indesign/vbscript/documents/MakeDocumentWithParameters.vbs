Rem MakeDocumentWithParameters.vbs
Rem An InDesign VBScript
Rem
Rem Creates a new document without showing the document window.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
End Function
Function mySnippet(myInDesign)
	Rem ![Create a document with parameters.]
	Rem Creates a new document without showing the document window.
	Rem The first parameter (ShowingWindow) controls the visibility of the document.
	Rem Hidden documents are not minimized, and will not appear until you
	Rem create a new window.
	Set myDocument = myInDesign.Documents.Add(False)
	Rem If you set the ShowingWindow parameter to False, you can
	Rem show the document by creating a new window.
	Set myLayoutWindow = myDocument.Windows.Add
	Rem ![Create a document with parameters.]
End Function
Function myTeardown(myInDesign)
End Function