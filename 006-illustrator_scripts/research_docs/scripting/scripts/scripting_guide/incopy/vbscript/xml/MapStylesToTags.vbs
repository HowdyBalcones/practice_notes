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
	Rem Add text elements.
	Set myStory = myDocument.Stories.Item(1)
	myStory.InsertionPoints.Item(-1).Contents = "Heading 1" & vbCr
	myStory.Paragraphs.Item(-1).ApplyParagraphStyle myHeading1Style, True
	myStory.InsertionPoints.Item(-1).Contents = "This is the first paragraph in the article." & vbCr
	myStory.Paragraphs.Item(-1).ApplyParagraphStyle myPara1Style, True
	myStory.InsertionPoints.Item(-1).Contents = "This is the second paragraph in the article." & vbCr
	myStory.Paragraphs.Item(-1).ApplyParagraphStyle myBodyTextStyle, True
	myStory.InsertionPoints.Item(-1).Contents = "Heading 2" & vbCr
	myStory.Paragraphs.Item(-1).ApplyParagraphStyle myHeading2Style, True
	myStory.InsertionPoints.Item(-1).Contents = "This is the first paragraph following the subhead." & vbCr
	myStory.Paragraphs.Item(-1).ApplyParagraphStyle myPara1Style, True
	myStory.InsertionPoints.Item(-1).Contents = "This is the second paragraph following the subhead." & vbCr
	myStory.Paragraphs.Item(-1).ApplyParagraphStyle myBodyTextStyle, True	
End Function
Function mySnippet(myInCopy)
	Set myDocument = myInCopy.Documents.Item(1)
	Rem Create a tag to style mapping.
	myDocument.XMLExportMaps.Add myDocument.ParagraphStyles.Item("heading 1"), myDocument.XMLTags.Item("heading_1")
	myDocument.XMLExportMaps.Add myDocument.ParagraphStyles.Item("heading 2"), myDocument.XMLTags.Item("heading_2")
	myDocument.XMLExportMaps.Add myDocument.ParagraphStyles.Item("para 1"), myDocument.XMLTags.Item("para_1")
	myDocument.XMLExportMaps.Add myDocument.ParagraphStyles.Item("body text"), myDocument.XMLTags.Item("body_text")
	Rem Apply the tag to style mapping.
	myDocument.MapStylesToXMLTags
End Function
Function myTeardown(myInCopy)
End Function