Rem CloseAll.vbs
Rem An InDesign VBScript
Rem
Rem Close all open documents without saving.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
    myInDesign.Documents.Add
    myInDesign.Documents.Add
    myInDesign.Documents.Add
End Function
Function mySnippet(myInDesign)
	Rem ![Close all documents.]
	For myCounter = myInDesign.Documents.Count To 1 Step -1
		myInDesign.Documents.Item(myCounter).Close idSaveOptions.idNo
	Next
	Rem ![Close all documents.]
End Function
Function myTeardown(myInDesign)
End Function


