Rem XMLImportPreferences.vbs
Rem An InCopy VBScript
Rem
Rem Sets XML import preferences for a document.
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
	Set myXMLImportPreferences = myDocument.XMLImportPreferences
	myXMLImportPreferences.AllowTransform = False
	myXMLImportPreferences.CreateLinkToXML = False
	myXMLImportPreferences.IgnoreUnmatchedIncoming = True
	myXMLImportPreferences.IgnoreWhitespace = True
	myXMLImportPreferences.ImportCALSTables = True
	myXMLImportPreferences.ImportStyle = idXMLImportStyles.idMergeImport
	myXMLImportPreferences.ImportTextIntoTables = False
	myXMLImportPreferences.ImportToSelected = False
	myXMLImportPreferences.RemoveUnmatchedExisting = False
	myXMLImportPreferences.RepeatTextElements = True
	Rem The following properties are only used when the
	Rem AllowTransform property is set to True.
	Rem myXMLImportPreferences.TransformFilename = "c:\myTransform.xsl"
	Rem If you have defined parameters in your XSL file, then you can pass
	Rem parameters to the file during the XML import process. For each parameter,
	Rem enter an array containing two strings. The first string is the name of the
	Rem parameter, the second is the value of the parameter.Rem myXMLImportPreferences.TransformParameters = Array(Array("format", "1"))
End Function
Function myTeardown(myInCopy)
End Function