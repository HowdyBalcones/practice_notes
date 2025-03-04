Rem TextExportPreferences.vbs
Rem An InDesign VBScript
Rem
Rem Sets the text export filter preferences.
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
	Rem ![Text export preferences.]
	With myInDesign.TextExportPreferences
		Rem Options for characterSet: idTextExportCharacterSet
		.CharacterSet = idTextExportCharacterSet.idUTF8
		Rem platform options: idImportPlatform
		.Platform = idImportPlatform.idPC
	End With
	Rem ![Text export preferences.]
End Function
Function myTeardown(myInDesign)
End Function