Rem OpenDocument.vbs
Rem An InDesign VBScript
Rem
Rem Opens an existing document.
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
	Rem ![Open a document.]
	Rem You'll have to fill in your own file path.
	Set myDocument = myInDesign.Open("C:\OpenDocument.indd")
	Rem ![Open a document.]
End Function
Function myTeardown(myInDesign)
End Function