Rem ListPreflightProfiles.vbs
Rem An InDesign VBScript
Rem
Rem Shows how to list all InDesign preflight profiles.

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
	Rem ![List preflight profiles.]
	Set profiles = myInDesign.PreflightProfiles
	profileCount = profiles.Count
	str = "Preflight profiles: "
	For i = 1 To profileCount
		If i > 1 Then
			str = str & ", "
		End If
		str = str & profiles.Item(i).Name
	Next
	MsgBox(str)
	Rem ![List preflight profiles.]
End Function

Function myTeardown(myInDesign)
End Function
