Rem PrintDocument.vbs
Rem An InDesign VBScript
Rem
Rem Prints the active document using the specified printer preset.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
	On Error Resume Next
	Set myPrinterPreset = myInDesign.PrinterPresets.Item("myPrinterPreset")
	If Err.Number <> 0 Then
		Set myPrinterPreset = myInDesign.PrinterPresets.Add
		myPrinterPreset.Name = "myPrinterPreset"
		Err.Clear
	End If
	On Error Resume Next
	Set myDocument = myInDesign.Documents.Add
	myDocument.Pages.Item(1).Rectangles.Add
End Function
Function mySnippet(myInDesign)
	Rem ![Print with preset.]
	Set myDocument = myInDesign.Documents.Item(1)
	Set myPrinterPreset = myInDesign.PrinterPresets.Item("myPrinterPreset")
	myDocument.PrintOut False, myPrinterPreset
	Rem ![Print with preset.]
End Function
Function myTeardown(myInDesign)
End Function 