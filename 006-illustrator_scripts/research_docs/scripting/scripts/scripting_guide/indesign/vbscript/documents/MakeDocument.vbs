Rem MakeDocument.vbs
Rem An InDesign VBScript
Rem
Rem Creates a new document.
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
   Rem ![Create a document.]
   Set myDocument = myInDesign.Documents.Add
   Rem ![Create a document.]
End Function
Function myTeardown(myInDesign)
End Function