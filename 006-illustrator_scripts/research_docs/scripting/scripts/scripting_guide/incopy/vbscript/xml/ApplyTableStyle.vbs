Rem ApplyTableStyle.vbs
Rem An InCopy VBScript
Rem 
Rem Shows how to convert a series of XML elements to a table
Rem using the ConvertTextToTableByTag method and apply a style
Rem to them.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
	Set myDocument = myInCopy.documents.add()
	Rem Create a series of XML tags.
	Set myRowTag = myDocument.xmlTags.add("row")
	Set myCellTag = myDocument.xmlTags.add("cell")
	Set myTableTag = myDocument.xmlTags.add("table")
	Rem Create a table style and a cell style.
	Set myTableStyle = myDocument.tableStyles.add
	myTableStyle.name = "myTableStyle"
	myTableStyle.startRowFillColor = myDocument.colors.item("Black")
	myTableStyle.startRowFillTint = 25
	myTableStyle.endRowFillColor = myDocument.colors.item("Black")
	myTableStyle.endRowFillTint = 10
	Set myCellStyle = myDocument.cellStyles.add
	myCellStyle.name = "myCellStyle"
	myCellStyle.fillColor = myDocument.colors.item("Black")
	myCellStyle.fillTint = 45
	Rem Add XML elements.
	Set myRootXMLElement = myDocument.xmlElements.item(1)
	with myRootXMLElement
		Set myTableXMLElement = .xmlElements.add(myTableTag)
		With myTableXMLElement
			for myRowCounter = 1 To 6
				With .xmlElements.add(myRowTag)
					myString = "Row " & CStr(myRowCounter)
					For myCellCounter = 1 To 4
						With .xmlElements.add(myCellTag)
							.contents = myString & ":Cell " & CStr(myCellCounter)
						End With
					Next
				End With
			Next
		End With
	End With
End Function
Function mySnippet(myInCopy)
	Set myTableXMLElement = myInCopy.Documents.Item(1).XMLElements.Item(1).XMLElements.Item(1)
	Set myTable = myTableXMLElement.convertElementToTable(myRowTag, myCellTag)
	Set myTableXMLElement = myDocument.xmlElements.item(1).xmlElements.item(1)
	myTableXMLElement.applyTableStyle(myTableStyle)
	myTableXMLElement.xmlElements.item(1).applyCellStyle(myCellStyle)
	myTableXMLElement.xmlElements.item(6).applyCellStyle(myCellStyle)
	myTableXMLElement.xmlElements.item(11).applyCellStyle(myCellStyle)
	myTableXMLElement.xmlElements.item(16).applyCellStyle(myCellStyle)
	myTableXMLElement.xmlElements.item(17).applyCellStyle(myCellStyle)
	myTableXMLElement.xmlElements.item(22).applyCellStyle(myCellStyle)
	Set myStory = myDocument.Stories.Item(1)
	myStory.placeXML myRootXMLElement
	myTable.alternatingFills = idAlternatingFillsTypes.idAlternatingRows
End Function
Function myTeardown(myInCopy)
End Function