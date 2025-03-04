Rem TaggedTextImportPreferences.vbs
Rem An InDesign VBScript
Rem
Rem Sets the tagged text import filter preferences.
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
	Rem ![Tagged text import preferences.]
	With myInDesign.TaggedTextImportPreferences
		.RemoveTextFormatting = False
		Rem .styleConflict property can be:
		Rem idStyleConflict.idPublicationDefinition
		Rem idStyleConflict.idTagFileDefinition
		.StyleConflict = idStyleConflict.idPublicationDefinition
		.UseTypographersQuotes = True
	End With
	Rem ![Tagged text import preferences.]
End Function
Function myTeardown(myInDesign)
End Function