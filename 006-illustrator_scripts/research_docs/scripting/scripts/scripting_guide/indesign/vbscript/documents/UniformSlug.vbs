Rem UniformSlug.vbs
Rem An InDesign VBScript
Rem
Rem Shows how to use the DocumentSlugUniformSize property.
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
	Rem ![Uniform slug.]
	Set myDocument = myInDesign.Documents.Item(1)
	Rem The slug properties belong to the DocumentPreferences object.
	With myDocument.DocumentPreferences
	Rem Slug:
		.SlugTopOffset = "4p"
		.DocumentSlugUniformSize = True
	End With
	Rem ![Uniform slug.]
End Function
Function myTeardown(myInDesign)
End Function