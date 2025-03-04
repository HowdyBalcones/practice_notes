Rem TranslateKeyString.vbs
Rem An InDesign VBScript
Rem
Rem Translates a key string (locale-independent) into a locale-specific string.
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
	Rem ![Translate key string.]
	Rem Fill in the appropriate key string in the following line.
	myString = myInDesign.TranslateKeyString("$ID/Convert To Note")
	MsgBox myString
	Rem ![Translate key string.]
End Function
Function myTeardown(myInDesign)
End Function