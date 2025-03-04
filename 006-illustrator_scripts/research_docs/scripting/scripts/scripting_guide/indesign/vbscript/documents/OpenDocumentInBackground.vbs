Rem OpenDocumentInBackground.vbs
Rem An InDesign VBScript
Rem
Rem Opens an existing document in the background, then shows the document.
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
	Rem ![Open a document in background.]
	Rem You'll have to fill in your own file path.
	Set myDocument = myInDesign.Open("C:\OpenDocInBackground.indd", False)
	Rem At this point, you can do things with the document without 
	Rem showing the document window. This can speed up many scripting
	Rem operations, and makes it possible for a script to operate
	Rem on a file in the background.
	MsgBox ("Document is open but not visible")
	Rem When you want to show the hidden document, create a new window.
	Set myLayoutWindow = myDocument.Windows.Add
	MsgBox ("Document is now visible")
	Rem ![Open a document in background.]
End Function
Function myTeardown(myInDesign)
End Function