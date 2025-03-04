Rem TranslateKeyString.vbs
Rem An InCopy VBScript
Rem
Rem Translates a key string (locale-independent) into a locale-specific string.
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
	Rem Fill in the appropriate key string in the following line.
	myString = myInCopy.TranslateKeyString("$ID/Convert To Note")
	MsgBox myString
	Rem </fragment>
End Function
Function myTeardown(myInCopy)
End Function

