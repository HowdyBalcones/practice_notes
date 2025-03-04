Rem XMLPreferences.vbs
Rem An InCopy VBScript
Rem
Rem Sets default XML tagging preferences.
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
	Set myDocument = myInCopy.Documents.Add
	Set myXMLPreferences = myDocument.XMLPreferences
	myXMLPreferences.DefaultCellTagColor = idUIColors.idBlue
	myXMLPreferences.DefaultCellTagName = "cell"
	myXMLPreferences.DefaultImageTagColor = idUIColors.idBrickRed
	myXMLPreferences.DefaultImageTagName = "image"
	myXMLPreferences.DefaultStoryTagColor = idUIColors.idCharcoal
	myXMLPreferences.DefaultStoryTagName = "text"
	myXMLPreferences.DefaultTableTagColor = idUIColors.idCuteTeal
	myXMLPreferences.DefaultTableTagName = "table"
End Function
Function myTeardown(myInCopy)
End Function