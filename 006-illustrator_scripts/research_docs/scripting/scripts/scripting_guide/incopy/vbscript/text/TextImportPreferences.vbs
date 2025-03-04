Rem TextImportPreferences.vbs
Rem An InCopy VBScript
Rem
Rem Sets the text import filter preferences.
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
	With myInCopy.TextImportPreferences
		Rem Options for characterSet:
		Rem idTextImportCharacterSet.idAnsi
		Rem idTextImportCharacterSet.idChineseBig5
		Rem idTextImportCharacterSet.idGB18030
		Rem idTextImportCharacterSet.idGB2312
		Rem idTextImportCharacterSet.idKSC5601
		Rem idTextImportCharacterSet.idMacintoshCE
		Rem idTextImportCharacterSet.idMacintoshCyrillic
		Rem idTextImportCharacterSet.idMacintoshGreek
		Rem idTextImportCharacterSet.idMacintoshTurkish
		Rem idTextImportCharacterSet.idRecommendShiftJIS83pv
		Rem idTextImportCharacterSet.idShiftJIS90ms
		Rem idTextImportCharacterSet.idshiftJIS90pv
		Rem idTextImportCharacterSet.idUTF16
		Rem idTextImportCharacterSet.idUTF8
		Rem idTextImportCharacterSet.idWindowsBaltic
		Rem idTextImportCharacterSet.idWindowsCE
		Rem idTextImportCharacterSet.idWindowsCyrillic
		Rem idTextImportCharacterSet.idWindowsEE
		Rem icTextImportCharacterSet.idWindowsGreek
		Rem idTextImportCharacterSet.idWindowsTurkish
		.CharacterSet = idTextImportCharacterSet.idUTF8
		.ConvertSpacesIntoTabs = True
		.SpacesIntoTabsCount = 3
		Rem The dictionary property can take any of the following
		Rem language names (as strings):
		Rem Bulgarian
		Rem Catalan
		Rem Croatian
		Rem Czech
		Rem Danish
		Rem Dutch
		Rem English:Canadian
		Rem English: UK
		Rem English: USA
		Rem English: USA Legal
		Rem English: USA Medical
		Rem Estonian
		Rem Finnish
		Rem French
		Rem French: Canadian
		Rem German: Reformed
		Rem German: Swiss
		Rem German: Traditional
		Rem Greek
		Rem Hungarian
		Rem Italian
		Rem Latvian
		Rem Lithuanian
		Rem Neutral
		Rem Norwegian: Bokmal
		Rem Norwegian: Nynorsk
		Rem Polish
		Rem Portuguese
		Rem Portuguese: Brazilian
		Rem Romanian
		Rem Russian
		Rem Slovak
		Rem Slovenian
		Rem Spanish: Castilian
		Rem Swedish
		Rem Turkish
		.Dictionary = "English: USA"
		Rem platform options:
		Rem idImportPlatform.idMacintosh
		Rem idImportPlatform.idPC
		.Platform = idImportPlatform.idPC
		.StripReturnsBetweenLines = True
		.StripReturnsBetweenParagraphs = True
		.UseTypographersQuotes = True
	End With
End Function
Function myTeardown(myInCopy)
End Function