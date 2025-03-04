Rem XMLViewPreferences.vbs
Rem An InDesign VBScript
Rem
Rem Sets Structure panel display options.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
   Set myDocument = myInDesign.Documents.Add
End Function
Function mySnippet(myInDesign)
   Rem ![XML view preferences.]
   Set myDocument = myInDesign.Documents.Item(1)
   Set myXMLViewPreferences = myDocument.XMLViewPreferences
   myXMLViewPreferences.ShowAttributes = True
   myXMLViewPreferences.ShowStructure = True
   myXMLViewPreferences.ShowTaggedFrames = True
   myXMLViewPreferences.ShowTagMarkers = True
   myXMLViewPreferences.ShowTextSnippets = True
   Rem ![XML view preferences.]
End Function
Function myTeardown(myInDesign)
End Function

