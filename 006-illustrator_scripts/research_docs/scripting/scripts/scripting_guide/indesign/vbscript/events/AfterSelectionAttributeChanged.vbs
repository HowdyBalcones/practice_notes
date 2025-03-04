Rem AfterSelectionAttributeChanged.vbs
Rem An InDesign VBScript
Rem 
Rem Shows how to detect changes to the selection.
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
	Rem Add an event listener that displays the type of the objects in the selection.
	Rem ![After selection attribute changed.]
	Set myDocument = myInDesign.Documents.Add
	myDocument.AddEventListener "afterSelectionAttributeChanged", GetRef("myCheckForRegistration")
	Rem ![After selection attribute changed.]
End Function
function myTeardown(myInDesign)
End Function
Rem ![After selection attribute changed - functions.]
Function myCheckForRegistration(en)
	myRegistrationSwatchUsed = false
	Set myInDesign = CreateObject("InDesign.Application.2024")
	If myInDesign.Documents.Count > 0 Then
		If myInDesign.Documents.Item(1).Selection.Count > 0 Then
			Set mySelection = myInDesign.Documents.Item(1).Selection
			For myCounter = 1 To mySelection.Count
				Set myFillColor = mySelection.Item(myCounter).FillColor
				Set myStrokeColor = mySelection.Item(myCounter).StrokeColor
				If myFillColor.Name = "Registration" Or myStrokeColor.Name = "Registration" Then
					myRegistrationSwatchUsed = True
				End If
			Next
			If myRegistrationSwatchUsed = True Then
				MsgBox("The Registration swatch is applied to some of the" & vbCr & "objects in the selection. Did you really intend to apply this swatch?")
			End If
		End If
	End If
End Function
Rem ![After selection attribute changed - functions.]