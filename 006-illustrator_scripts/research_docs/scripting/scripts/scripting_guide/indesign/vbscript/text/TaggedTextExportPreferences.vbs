Rem TaggedTextExportPreferences.vbs
Rem An InDesign VBScript
Rem
Rem Sets the tagged text export filter preferences.
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
	Rem ![Tagged text export preferences.]
	Set myInDesign = CreateObject("InDesign.Application.2024")
	With myInDesign.TaggedTextExportPreferences
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
	Rem ![Tagged text export preferences.]
End Function
Function myTeardown(myInDesign)
End Function