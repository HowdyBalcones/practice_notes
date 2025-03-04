Rem MapTagsToStyles.vbs
Rem An InCopy VBScript
Rem
Rem Demonstrates XML tag to style mapping.
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
	Set myHeading1XMLTag = myDocument.XMLTags.Add("heading_1")
	Set myHeading2XMLTag = myDocument.XMLTags.Add("heading_2")
	Set myPara1XMLTag = myDocument.XMLTags.Add("para_1")
	Set myBodyTextXMLTag = myDocument.XMLTags.Add("body_text")
	Rem Create a series of paragraph styles.
	Set myHeading1Style = myDocument.ParagraphStyles.Add
	myHeading1Style.Name = "heading 1"
	myHeading1Style.PointSize = 24
	Set myHeading2Style = myDocument.ParagraphStyles.Add
	myHeading2Style.Name = "heading 2"
	myHeading2Style.PointSize = 14
	myHeading2Style.SpaceBefore = 12
	Set myPara1Style = myDocument.ParagraphStyles.Add
	myPara1Style.Name = "para 1"
	myPara1Style.PointSize = 12
	myPara1Style.FirstLineIndent = 0
	Set myBodyTextStyle = myDocument.ParagraphStyles.Add
	myBodyTextStyle.Name = "body text"
	myBodyTextStyle.PointSize = 12
	myBodyTextStyle.FirstLineIndent = 24
	Rem Add XML elements.
	Set myRootXMLElement = myDocument.XMLElements.Item(1)
	Set myXMLElementA = myRootXMLElement.XMLElements.Add(myHeading1XMLTag)
	myXMLElementA.Contents = "Heading 1"
	myXMLElementA.InsertTextAsContent vbCr, idXMLElementPosition.idAfterElement
	Set myXMLElementB = myRootXMLElement.XMLElements.Add(myPara1XMLTag)
	myXMLElementB.Contents = "This is the first paragraph in the article."
	myXMLElementB.InsertTextAsContent vbCr, idXMLElementPosition.idAfterElement
	Set myXMLElementC = myRootXMLElement.XMLElements.Add(myBodyTextXMLTag)
	myXMLElementC.Contents = "This is the second paragraph in the article."
	myXMLElementC.InsertTextAsContent vbCr, idXMLElementPosition.idAfterElement
	Set myXMLElementD = myRootXMLElement.XMLElements.Add(myHeading2XMLTag)
	myXMLElementD.Contents = "Heading 2"
	myXMLElementD.InsertTextAsContent vbCr, idXMLElementPosition.idAfterElement
	Set myXMLElementE = myRootXMLElement.XMLElements.Add(myPara1XMLTag)
	myXMLElementE.Contents = "This is the first paragraph following the subhead."
	myXMLElementE.InsertTextAsContent vbCr, idXMLElementPosition.idAfterElement
	Set myXMLElementF = myRootXMLElement.XMLElements.Add(myBodyTextXMLTag)
	myXMLElementF.Contents = "This is the second paragraph following the subhead."
	myXMLElementF.InsertTextAsContent vbCr, idXMLElementPosition.idAfterElement
	Set myStory = myDocument.Stories.Item(1)
	Rem Associate the root XML element with the text frame.
	myRootXMLElement.PlaceXML myStory
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Rem Create a tag to style mapping.
	myDocument.XMLImportMaps.Add myDocument.XMLTags.Item("heading_1"), myDocument.ParagraphStyles.Item("heading 1")
	myDocument.XMLImportMaps.Add myDocument.XMLTags.Item("heading_2"), myDocument.ParagraphStyles.Item("heading 2")
	myDocument.XMLImportMaps.Add myDocument.XMLTags.Item("para_1"), myDocument.ParagraphStyles.Item("para 1")
	myDocument.XMLImportMaps.Add myDocument.XMLTags.Item("body_text"), myDocument.ParagraphStyles.Item("body text")
	Rem Apply the XML tag to style mapping.
	myDocument.MapXMLTagsToStyles
End Function
Function myTeardown(myInCopy)
End Function