Rem ConvertXMLElementToTable.vbs
Rem An InCopy VBScript
Rem
Rem Shows how to convert a series of XML elements to a table
Rem using the ConvertTextToTableByTag method.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.Documents.Add
	Rem Create a series of XML tags.
	Set myRowTag = myDocument.XMLTags.Add("row")
	Set myCellTag = myDocument.XMLTags.Add("cell")
	Set myTableTag = myDocument.XMLTags.Add("table")
	Rem Add XML elements.
	Set myRootXMLElement = myDocument.XMLElements.Item(1)
	With myRootXMLElement
	    Set myTableXMLElement = .XMLElements.Add(myTableTag)
	    With myTableXMLElement
	        For myRowCounter = 1 To 6
	            With .XMLElements.Add(myRowTag)
	                .Contents = "Row " + CStr(myRowCounter)
	                For myCellCounter = 1 To 4
	                    With .XMLElements.Add(myCellTag)
	                        .Contents = "Cell " + CStr(myCellCounter)
	                    End With
	                Next
	            End With
	        Next
	    End With
	End With
End Function
Function mySnippet(myInCopy)
	Set myTableElement = myInCopy.Documents.Item(1).XMLElements.Item(1).XMLElements.Item(1)
	Set myTable = myTableXMLElement.ConvertElementToTable(myRowTag, myCellTag)
	Set myStory = myDocument.Stories.Item(1)
	myDocument.XMLElements.Item(1).PlaceXML myStory
End Function
Function myTeardown(myInCopy)
End Function