Rem WordRTFImportPreferences.vbs
Rem An InCopy VBScript
Rem
Rem Sets the Word/RTF import filter preferences.
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
	Rem <fragment>
	With myInCopy.WordRTFImportPreferences
		Rem convertPageBreaks property can be:
		Rem idConvertPageBreaks.idColumnBreak
		Rem idConvertPageBreaks.idNone
		Rem idConvertPageBreaks.idPageBreak
		.ConvertPageBreaks = idConvertPageBreaks.idNone
		Rem convertTablesTo property can be:
		Rem idConvertTablesOptions.idUnformattedTabbedText
		Rem idConvertTablesOptions.idUnformattedTable
		.ConvertTablesTo = idConvertTablesOptions.idUnformattedTable
		.ImportEndnotes = True
		.ImportFootnotes = True
		.ImportIndex = True
		.ImportTOC = True
		.ImportUnusedStyles = False
		.PreserveGraphics = False
		.PreserveLocalOverrides = False
		.PreserveTrackChanges = False
		.RemoveFormatting = False
		Rem resolveCharacterStyleClash and resolveParagraphStyleClash properties can be:
		Rem idResolveStyleClash.idResolveClashAutoRename
		Rem idResolveStyleClash.iduseExisting
		Rem idResolveStyleClash.iduseNew
		.ResolveCharacterStyleClash = idResolveStyleClash.idResolveClashUseExisting
		.ResolveParagraphStyleClash = idResolveStyleClash.idResolveClashUseExisting
		.UseTypographersQuotes = True
	End With
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function