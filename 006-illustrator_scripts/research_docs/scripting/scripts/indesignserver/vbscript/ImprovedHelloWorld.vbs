Rem ImprovedHelloWorld.vbs
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
Set myPage = myDocument.Pages.Item(1)
Set myTextFrame = myPage.TextFrames.Add
myTextFrame.Contents = "Hello World!"
Rem Get page width and page height using the function "myGetBounds".
myBounds = myGetBounds(myDocument, myPage)
Rem Resize the text frame to match the publication margins.
myTextFrame.GeometricBounds = myBounds
Set myParagraph = myTextFrame.Paragraphs.Item(1)
Rem Change the font, size, and alignment.
Rem Enter the name of a font on your system, if necessary.
If TypeName(myInDesignServer.Fonts.Item("Arial"))<>"Nothing" Then
	Set myFont = myInDesignServer.Fonts.Item("Arial")
	myParagraph.AppliedFont = myFont
End If
myParagraph.PointSize = 48
Rem If you are running the script using the Application.DoScript 
Rem method, you can use the full name of the justification enumeration:
Rem myParagraph.Justification = idJustification.idCenterAlign
Rem If you are running the script from Windows Explorer, use
Rem the decimal version of the enumeration:
myParagraph.Justification = 1667591796
Rem Set the first baseline offset of the text frame to ascent.
Rem If you are running the script using the Application.DoScript 
Rem method, you can use the full name of the justification enumeration:
Rem myTextFrame.TextFramePreferences.FirstBaselineOffset = idFirstBaseline.idAscentOffset
Rem If you are running the script from Windows Explorer, use
Rem the decimal version of the enumeration:
myTextFrame.TextFramePreferences.FirstBaselineOffset = 1296135023
Rem Set the vertical justification of the text frame to center.
Rem If you are running the script using the Application.DoScript 
Rem method, you can use the full name of the justification enumeration:
Rem myTextFrame.TextFramePreferences.VerticalJustification = 
Rem idVerticalJustification.idCenterAlign
Rem If you are running the script from Windows Explorer, use
Rem the decimal version of the enumeration:
myTextFrame.TextFramePreferences.VerticalJustification = 1667591796
Rem Export the document as PDF (fill in a valid file path).
Rem myDocument.Export idExportFormat.idPDFType "c:\ImprovedHelloWorld.indd"
myDocument.Export 1952403524, "c:\ImprovedHelloWorld.pdf"
Rem Close the document.
myInDesignServer.Documents.Item(1).Close

Function myGetBounds(myDocument, myPage)
	myPageHeight = myDocument.DocumentPreferences.PageHeight
	myPageWidth = myDocument.DocumentPreferences.PageWidth
	myTop = myPage.MarginPreferences.Top
	myLeft = myPage.MarginPreferences.Left
	myRight = myPage.MarginPreferences.Right
	myBottom = myPage.MarginPreferences.Bottom
	myRight = myPageWidth - myRight
	myBottom = myPageHeight - myBottom
	myGetBounds = Array(myTop, myLeft, myBottom, myRight)
End Function