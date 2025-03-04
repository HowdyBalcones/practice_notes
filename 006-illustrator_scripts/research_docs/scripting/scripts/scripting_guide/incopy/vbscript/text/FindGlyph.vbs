Rem FindGlyph.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to use find glyph/change glyph.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	Set myStory = myDocument.Stories.Item(1)
	myString = "This is an example paragraph containing a specific glyph: <25A0>." & vbCr
	myString = myString & "This is an example paragraph containing a specific glyph: <25A0>." & vbCr
	myString = myString & "This is an example paragraph containing a specific glyph: <25A0>." & vbCr
	myStory.Contents = myString
	myFontName = "Times New Roman" & vbTab & "Regular"
	myStory.Texts.Item(1).AppliedFont = myInCopy.Fonts.Item(myFontName)
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Rem Clear the find/change preferences.
	myInCopy.FindGlyphPreferences = idNothingEnum.idNothing
	myInCopy.ChangeGlyphPreferences = idNothingEnum.idNothing
	Rem Set the find options.
	myInCopy.FindChangeGrepOptions.IncludeFootnotes = False
	myInCopy.FindChangeGrepOptions.IncludeHiddenLayers = False
	myInCopy.FindChangeGrepOptions.IncludeLockedLayersForFind = False
	myInCopy.FindChangeGrepOptions.IncludeLockedStoriesForFind = False
	myInCopy.FindChangeGrepOptions.IncludeMasterPages = False
	Rem You must provide a font that is used in the document for the
	Rem AppliedFont property of the FindGlyphPreferences object.
	myInCopy.FindGlyphPreferences.AppliedFont = myDocument.Fonts.Item("Minion Pro	Regular")
	Rem Provide the glyph ID, not the glyph Unicode value.
	myInCopy.FindGlyphPreferences.GlyphID = 500
	Rem The appliedFont of the changeGlyphPreferences object can be
	Rem any font available to the application.
	myInCopy.changeGlyphPreferences.AppliedFont = myInCopy.Fonts.Item("Times New Roman	Regular")
	myInCopy.ChangeGlyphPreferences.GlyphID = 374
	myDocument.ChangeGlyph
	Rem Clear the find/change preferences after the search.
	myInCopy.FindGlyphPreferences = idNothingEnum.idNothing
	myInCopy.ChangeGlyphPreferences = idNothingEnum.idNothing
End Function
Function myTeardown(myInCopy)
End Function