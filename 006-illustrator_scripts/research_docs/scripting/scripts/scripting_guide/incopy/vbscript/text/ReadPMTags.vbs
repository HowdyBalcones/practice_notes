Rem ReadPMTags.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to use regular expressions to read an imported PageMaker paragraph tags file.
Rem PageMaker paragraph tags (which are not the same as PageMaker tagged text format files) are a
Rem simplified text markup scheme. Paragraph style names appear at the start of a paragraph:
Rem <heading1>This is some text.
Rem <body_text>This is body text.
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
   Rem Create some example marked-up text (as if it had been imported).
   myString = "<heading1>Heading One." & vbCr
   myString = myString & "<body_text>This is an example paragraph of body text." & vbCr
   myString = myString & "<body_text>This is another example paragraph of body text." & vbCr
   myString = myString & "<heading2>Heading Two." & vbCr
   myString = myString & "<body_text>This is an example paragraph of body text." & vbCr
   myString = myString & "<body_text>This is another example paragraph of body text." & vbCr
   myString = myString & "<heading2>Heading Two." & vbCr
   myString = myString & "<body_text>This is an example paragraph of body text." & vbCr
   myString = myString & "<body_text>This is another example paragraph of body text." & vbCr
   myStory.Contents = myString
End Function
Function mySnippet(myInCopy)
   Rem <fragment>
   Set myInCopy = CreateObject("InCopy.Application.2024")
   Rem Access the active document.
   Set myDocument = myInCopy.Documents.Item(1)
   Set myStory = myDocument.Stories.Item(1)
   myReadPMTags myInCopy, myStory
   Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function
Rem <fragment>
Function myReadPMTags(myInCopy, myStory)
   Set myDocument = myStory.Parent
   Rem Reset the findGrepPreferences to ensure that previous settings
   Rem do not affect the search.
   myInCopy.FindGrepPreferences = idNothingEnum.idNothing
   myInCopy.ChangeGrepPreferences = idNothingEnum.idNothing
   Rem Find the tags.
   myInCopy.FindGrepPreferences.findWhat = "(?i)^<\s*\w+\s*>"
   Set myFoundItems = myStory.findGrep
   If myFoundItems.Count <> 0 Then
     Set myFoundTags = CreateObject("Scripting.Dictionary")
     For myCounter = 1 To myFoundItems.Count
         If Not (myFoundTags.Exists(myFoundItems.Item(myCounter).Contents)) Then
             myFoundTags.Add myFoundItems.Item(myCounter).Contents, myFoundItems.Item(myCounter).Contents
         End If
     Next
     Rem At this point, we have a list of tags to search for.
     For Each myFoundTag In myFoundTags
         myString = myFoundTag
         Rem Find the tag using findWhat.
         myInCopy.FindTextPreferences.findWhat = myString
         Rem Extract the style name from the tag.
         myStyleName = Mid(myString, 2, Len(myString) - 2)
         Rem Create the style if it does not already exist.
         Set myStyle = myAddStyle(myDocument, myStyleName)
         Rem Apply the style to each instance of the tag.
         myInCopy.ChangeTextPreferences.AppliedParagraphStyle = myStyle
         myStory.ChangeText
         Rem Reset the changeTextPreferences.
         myInCopy.ChangeTextPreferences = idNothingEnum.idNothing
         Rem Set the changeTo to an empty string.
         myInCopy.ChangeTextPreferences.ChangeTo = ""
         Rem Search to remove the tags.
         myStory.ChangeText
         Rem Reset the find/change preferences again.
         myInCopy.ChangeTextPreferences = idNothingEnum.idNothing
     Next
   End If
   myInCopy.FindGrepPreferences = idNothingEnum.idNothing
   myInCopy.ChangeGrepPreferences = idNothingEnum.idNothing
End Function
Rem</fragment>
Function myAddStyle(myDocument, myStyleName)
	On Error Resume Next
	Set myStyle = myDocument.ParagraphStyles.Item(myStyleName)
	If Err.Number <> 0 Then
		Set myStyle = myDocument.ParagraphStyles.Add
		myStyle.Name = myStyleName
		Err.Clear
	End If
	On Error GoTo 0
	Set myAddStyle = myStyle
End Function