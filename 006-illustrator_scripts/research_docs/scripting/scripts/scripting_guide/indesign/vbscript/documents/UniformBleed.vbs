Rem UniformBleed.vbs
Rem An InDesign VBScript
Rem
Rem Shows how to use the DocumentBleedUniformSize property.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
	myInDesign.Documents.Add
End Function
Function mySnippet(myInDesign)
	Rem ![Uniform bleed.]
	Set myDocument = myInDesign.Documents.Item(1)
	Rem The bleed properties belong to the DocumentPreferences object.
	With myDocument.DocumentPreferences
	Rem Bleed
		.DocumentBleedTopOffset = "2p"
		.DocumentBleedUniformSize = True
	End With
	Rem ![Uniform bleed.]
End Function
Function myTeardown(myInDesign)
End Function