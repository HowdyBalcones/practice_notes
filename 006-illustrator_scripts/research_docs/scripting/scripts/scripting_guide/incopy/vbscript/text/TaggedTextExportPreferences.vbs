Rem TaggedTextExportPreferences.vbs
Rem An InCopy VBScript
Rem
Rem Sets the tagged text export filter preferences.
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
	With myInCopy.TaggedTextExportPreferences
		Rem Options for characterSet:
		Rem idTagTextExportCharacterSet.idAnsi
		Rem idTagTextExportCharacterSet.idASCII
		Rem idTagTextExportCharacterSet.idGB18030
		Rem idTagTextExportCharacterSet.idKSC5601
		Rem idTagTextExportCharacterSet.idShiftJIS
		Rem idTagTextExportCharacterSet.idUnicode
		.CharacterSet = idTagTextExportCharacterSet.idUnicode
		Rem tagForm options:
		Rem idTagTextForm.idAbbreviated
		Rem idTagTextForm.idVerbose
		.TagForm = idTagTextForm.idVerbose
	End With
End Function
Function myTeardown(myInCopy)
End Function
