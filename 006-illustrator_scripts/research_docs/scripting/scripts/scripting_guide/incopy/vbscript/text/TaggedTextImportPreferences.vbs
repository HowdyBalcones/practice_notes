Rem TaggedTextImportPreferences.vbs
Rem An InCopy VBScript
Rem
Rem Sets the tagged text import filter preferences.
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
	With myInCopy.TaggedTextImportPreferences
		.RemoveTextFormatting = False
		Rem .styleConflict property can be:
		Rem idStyleConflict.idPublicationDefinition
		Rem idStyleConflict.idTagFileDefinition
		.StyleConflict = idStyleConflict.idPublicationDefinition
		.UseTypographersQuotes = True
	End With
End Function
Function myTeardown(myInCopy)
End Function

