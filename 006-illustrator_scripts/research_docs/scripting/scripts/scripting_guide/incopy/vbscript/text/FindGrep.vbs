Rem FindGrep.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to use regular expressions (i.e., "grep") to find and change text.
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
	myString = "This is an email address: okvern@adobe.com or anyone@adobe.com." & vbCr & "This is some more copy with an email address that is not 24-points: okvern@adobe.com or anyone@adobe.com" & vbCr & "This is even more example copy in 24 point text. With an email address: okvern@adobe.com." & vbCr & "This is copy in another paragraph." & vbCr
	myStory.Contents = myString
	Rem Apply formatting to the text.
	myStory.Paragraphs.Item(1).PointSize = 24
	myStory.Paragraphs.Item(2).PointSize = 12
	myStory.Paragraphs.Item(3).PointSize = 24
	myStory.Paragraphs.Item(4).PointSize = 12
End Function
Function mySnippet(myInCopy)
	Rem Clear the find/change preferences.
	myInCopy.FindGrepPreferences = idNothingEnum.idNothing
	myInCopy.ChangeGrepPreferences = idNothingEnum.idNothing
	Rem Set the find options.
	myInCopy.FindChangeGrepOptions.IncludeFootnotes = False
	myInCopy.FindChangeGrepOptions.IncludeHiddenLayers = False
	myInCopy.FindChangeGrepOptions.IncludeLockedLayersForFind = False
	myInCopy.FindChangeGrepOptions.IncludeLockedStoriesForFind = False
	myInCopy.FindChangeGrepOptions.IncludeMasterPages = False
	Rem Regular expression for finding an email address.
	myInCopy.FindGrepPreferences.FindWhat = "(?i)[A-Z]*?@[A-Z]*?[.]..."
	Rem Apply the change to 24-point text only.
	myInCopy.FindGrepPreferences.PointSize = 24
	myInCopy.ChangeGrepPreferences.Underline = True
	myInCopy.Documents.Item(1).ChangeGrep
	Rem Clear the find/change preferences after the search.
	myInCopy.FindGrepPreferences = idNothingEnum.idNothing
	myInCopy.ChangeGrepPreferences = idNothingEnum.idNothing
End Function
Function myTeardown(myInCopy)
End Function