Rem ApplyMaster.vbs
Rem An InDesign VBScript
Rem
Rem Applies a master spread to a page.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
    Set myDocument = myInDesign.Documents.Add
    Rem Disable normal error handling.
    On Error Resume Next
    Set myMasterSpread = myDocument.MasterSpreads.Item("B-Master")
    Rem If the master spread did not exist, handle the error
    Rem and create the master spread.
    If(Err<>0) Then
    	Set myMasterSpread = myDocument.MasterSpreads.Add
    	myMasterSpread.Name = "B-Master"
    	Err.Clear
    End If
    Rem Restore normal error handling.
    On Error Goto 0    
End Function
Function mySnippet(myInDesign)
    Rem ![Apply master spread.]
    Set myDocument = myInDesign.Documents.Item(1)
    Set myPage = myDocument.Pages.Add
    Set myPage.appliedMaster = myDocument.MasterSpreads.Item("B-Master")
    Rem ![Apply master spread.]
End Function
Function myTeardown(myInDesign)
End Function