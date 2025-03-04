Rem FindChangeFormatting.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to find and change text formatting.
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
	myString = "This is some copy." & vbcr & "This is some more copy." & vbcr & "This is even more example copy." & vbcr & "This is copy in another paragraph."
	myStory.Contents = myString
	Rem Apply formatting to the text.
	myStory.Paragraphs.Item(1).pointSize = 24
	myStory.Paragraphs.Item(2).pointSize = 12
	myStory.Paragraphs.Item(3).pointSize = 24
	myStory.Paragraphs.Item(4).pointSize = 12
End Function
Function mySnippet(myInCopy)
	Rem Clear the find/change preferences.
	myInCopy.FindTextPreferences = idNothingEnum.idNothing
	myInCopy.ChangeTextPreferences = idNothingEnum.idNothing
	Rem Set the find options.
	myInCopy.FindChangeTextOptions.CaseSensitive = False
	myInCopy.FindChangeTextOptions.IncludeFootnotes = False
	myInCopy.FindChangeTextOptions.IncludeHiddenLayers = False
	myInCopy.FindChangeTextOptions.IncludeLockedLayersForFind = False
	myInCopy.FindChangeTextOptions.IncludeLockedStoriesForFind = False
	myInCopy.FindChangeTextOptions.IncludeMasterPages = False
	myInCopy.FindChangeTextOptions.WholeWord = False
	Rem Search the document for the 24 point text and change it to 10 point text.
	myInCopy.FindTextPreferences.PointSize = 24
	myInCopy.ChangeTextPreferences.PointSize = 10
	Set myFoundItems = myInCopy.Documents.Item(1).ChangeText
	myInCopy.FindTextPreferences = idNothingEnum.idNothing
	myInCopy.ChangeTextPreferences = idNothingEnum.idNothing
End Function
Function myTeardown(myInCopy)
End Function