Rem SaveAsTemplate.vbs
Rem An InDesign VBScript
Rem
Rem Save the active document as a template.
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
	Rem ![Save as template.]
	set myDocument = myInDesign.Documents.Item(1)
	If myDocument.Saved = True Then
		Rem Convert the file name to a string.
		myFileName = myDocument.FullName
		Rem If the file name contains the extension ".indd", change it to ".indt".
		If InStr(1, myFileName, ".indd") <> 0 Then
			myFileName = Replace(myFileName, ".indd", ".indt")
		End If
	Else
		Rem If the document has not been saved, then give it a
		Rem default file name/file path.
		myFileName = "C:\SaveAsTemplate.indt"
	End If
	myDocument.Save myFileName, True
	Rem ![Save as template.]
End Function
Function myTeardown(myInDesign)
End Function