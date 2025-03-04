Rem CloseDocument.vbs
Rem An InDesign VBScript
Rem
Rem Close the active document.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
   Set myDocument = myInDesign.Documents.Add
End Function
Function mySnippet(myInDesign)
   Rem ![Close a document.]
   myInDesign.Documents.Item(1).Close
   Rem ![Close a document.]
End Function
Function myTeardown(myInDesign)
End Function
