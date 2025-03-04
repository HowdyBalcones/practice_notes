Rem DoScriptParameters.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to send parameters to a script run via the DoScript method.
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
	myJavaScript = "alert(""First argument: "" + arguments[0] + ""\rSecond argument: "" + arguments[1]);"
	myInCopy.DoScript myJavaScript, idScriptLanguage.idJavascript, Array("Hello from DoScript", "Your message here.")
	myVBScript = "msgbox arguments(1), vbOKOnly, ""First argument: "" & arguments(0)"
	myInCopy.DoScript myVBScript, idScriptLanguage.idVisualBasic, Array("Hello from DoScript", "Your message here.")
End Function
Function myTeardown(myInCopy)
End Function

