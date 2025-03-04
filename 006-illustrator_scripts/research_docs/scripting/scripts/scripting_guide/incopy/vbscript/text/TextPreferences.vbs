Rem TextPreferences.vbs
Rem An InCopy VBScript
Rem
Rem Sets text preferences.
Rem
Rem The following sets the text preferences for the application; to set the
Rem text preferences for the front-most document, replace "myInCopy.textPreferences" with
Rem "myInCopy.documents.item(1).textPreferences"
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
	With myInCopy.TextPreferences
		.AbutTextToTextWrap = True
		Rem baseline shift key increment can range from .001 to 200 points.
		.BaselineShiftKeyIncrement = 1
		.HighlightCustomSpacing = False
		.HighlightHjViolations = True
		.HighlightKeeps = True
		.HighlightSubstitutedFonts = True
		.HighlightSubstitutedGlyphs = True
		.JustifyTextWraps = True
		Rem kerning key increment value is 1/1000 of an em.
		.KerningKeyIncrement = 10
		Rem leading key increment value can range from .001 to 200 points.
		.LeadingKeyIncrement = 1
		.LinkTextFilesWhenImporting = False
		.ScalingAdjustsText = False
		.ShowInvisibles = True
		.SmallCap = 60
		.SubscriptPosition = 30
		.SubscriptSize = 60
		.SuperscriptPosition = 30
		.SuperscriptSize = 60
		.TypographersQuotes = False
		.UseOpticalSize = False
		.UseParagraphLeading = False
		.ZOrderTextWrap = False
	End With
	Rem Text editing preferences are application-wide.
	With myInDesign.TextEditingPreferences
		.AllowDragAndDropTextInStory = True
		.DragAndDropTextInLayout = True
		.SmartCutAndPaste = True
		.TripleClickSelectsLine = False
	End With
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function