Rem ImportPreflightProfiles.vbs
Rem An InDesign VBScript
Rem
Rem Shows how to import an InDesign preflight profiles.

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
	Rem ![Import preflight profile.]
	Set myProfile = myInDesign.LoadPreflightProfile("c:\Test.idpp")
	MsgBox("Preflight profile " & myProfile.Name & " is loaded.")
	Rem ![Import preflight profile.]
End Function

Function myTeardown(myInDesign)
End Function
