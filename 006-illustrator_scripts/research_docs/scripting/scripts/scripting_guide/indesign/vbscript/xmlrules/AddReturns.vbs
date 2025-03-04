Rem AddReturns.vbs
Rem An InDesign VBScript
Rem
Rem Defines a simple XML rule.

main

Function main()
   mySetup
   mySnippet
   myTeardown
End Function

Function mySetup()
    Set myInDesign = CreateObject("InDesign.Application.2024")
	myFilePath = myFindFile(myInDesign, "\XMLRuleExampleSetup.vbs", "VBS files|*.vbs")
	myInDesign.DoScript myFilePath
End Function

Function mySnippet()
   Rem ![Add returns.]
   Set myInDesign = CreateObject("InDesign.Application.2024")
   Set myDocument = myInDesign.ActiveDocument
   myFilePath = myInDesign.FilePath
   myFilePath = myFilePath & "\Scripts\Xml rules\glue code.vbs"
   Rem Use the Include function to load the glue code file.
   Include myFilePath
   Set myAddReturns = new AddReturns
   myRuleSet = Array(myAddReturns)
   Rem The fourth parameter of __processRuleSet is a
   Rem prefix mapping table; we'll leave it empty.
   glueCode_ProcessRuleSet myInDesign, myDocument.XMLElements.Item(1), myRuleSet, Array() 
   Rem ![Add returns.]
End Function

Function myTeardown()
End Function

Function myFindFile(myInDesign, myRelativePath, myFilter)
	myFilePath = myInDesign.ActiveScript
	Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
	myFolderPath = myFileSystemObject.GetFile(myFilePath).ParentFolder.Path
	myFilePath = myFolderPath & myRelativePath
	If myFileSystemObject.FileExists(myFilePath) = True Then
		myFile = myFilePath
	Else
		MsgBox "Can't find the XMLRuleExampleSetup.vbs file"
	End If
	myFindFile = myFile
End Function

Rem ![Add returns - functions.]
Rem XML rule "AddReturns"
Class AddReturns
	Public Property Get name
		name = "AddReturns"
	End Property
	Public Property Get xpath
		xpath = "//*"
	End Property
	Public Function apply (myXMLElement, myRulesProcessor)
		With myXMLElement
			Rem Add a return character at the end of the XML element.
			.InsertTextAsContent vbcr, idXMLElementPosition.idElementEnd
		End With
		apply = False
	End Function 
End Class
Function Include(myScriptFilePath)
	Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
	Set myScriptFile = myFileSystemObject.OpenTextFile(myScriptFilePath)
	myScriptContents = myScriptFile.ReadAll
	ExecuteGlobal myScriptContents
End Function
Rem ![Add returns - functions.]

