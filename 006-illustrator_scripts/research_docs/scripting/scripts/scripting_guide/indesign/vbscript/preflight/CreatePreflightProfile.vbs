Rem CreatePreflightProfile.vbs
Rem An InDesign VBScript
Rem
Rem Shows how to create an InDesign preflight profile.

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
	Rem ![Create preflight profile.]
	Set myProfile = myInDesign.PreflightProfiles.Add()
	myProfile.Name = "Test"
	myProfile.Description = "Test description"
	MsgBox("Preflight profile " & myProfile.Name & " is created.")
	Rem ![Create preflight profile.]
End Function

Function myTeardown(myInDesign)
End Function
