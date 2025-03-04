Rem DoScriptReturnValues.vbs
Rem An InCopy VBScript
Rem 
Rem Shows how to return values from a script run
Rem using the DoScript method.
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
    myStory.Contents = "Example paragraph." & vbCr
End Function
Function mySnippet(myInCopy)
	Rem <fragment>
	Set myDocument = myInCopy.Documents.Item(1)
    Set myStory = myDocument.Stories.Item(1)
    Set myParagraph = myStory.Paragraphs.Item(1)
	myJavaScript = "myParagraph = arguments[0];" & vbCr
	myJavaScript = myJavaScript & "var myDuplicate = myParagraph.duplicate(LocationOptions.after, myParagraph);" & vbCr
	myJavaScript = myJavaScript & "myDuplicate;" & vbCr
	Rem Create an array for the parameters we want to pass to the JavaScript.
	myArguments = Array(myParagraph)
	Set myDuplicate = myInCopy.DoScript(myJavaScript, idScriptLanguage.idJavascript, myArguments)
	Rem Change the text in the duplicated paragraph.
	myDuplicate.InsertionPoints.Item(1).Contents = "Duplicated paragraph: "
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function