Rem TextExportPreferences.vbs
Rem An InCopy VBScript
Rem
Rem Sets the text export filter preferences.
Rem
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
End Function
Function mySnippet(myInCopy)
	With myInCopy.TextExportPreferences
	    Rem Options for characterSet:
	    Rem idTextExportCharacterSet.idDefaultPlatform
	    Rem idTextExportCharacterSet.idUTF16
	    Rem idTextExportCharacterSet.idUTF8
	    .CharacterSet = idTextExportCharacterSet.idUTF16
	    Rem platform options:
	    Rem idImportPlatform.idMacintosh
	    Rem idImportPlatform.idPC
	    .Platform = idImportPlatform.idPC
	End With
End Function
Function myTeardown(myInCopy)
End Function