Rem MakeTextFrameWithinMargins.vbs
Rem An InDesign VBScript
Rem
Rem Creates a text frame in an example document.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
   Set myDocument = myInDesign.Documents.Add
End Function
Function mySnippet(myInDesign)
   Rem ![Create a text frame within margins.]
   Set myDocument = myInDesign.Documents.Item(1)
   Set myPage = myDocument.Pages.Item(1)
   Rem Create a text frame on the current page.
   Set myTextFrame = myPage.TextFrames.Add
   Rem Set the bounds of the text frame.
   myTextFrame.GeometricBounds = myGetBounds(myDocument, myDocument.Pages.Item(1))
   Rem Enter text in the text frame.
   myTextFrame.Contents = "This is some example text."
   Rem ![Create a text frame within margins.]
End Function
Function myTeardown(myInDesign)
End Function
Rem ![Create a text frame within margins - functions.]
Function myGetBounds(myDocument, myPage)
	myPageWidth = myDocument.DocumentPreferences.PageWidth
	myPageHeight = myDocument.DocumentPreferences.PageHeight
	If myPage.Side = idPageSideOptions.idLeftHand Then
		myX2 = myPage.MarginPreferences.Left
		myX1 = myPage.MarginPreferences.Right
	Else
		myX1 = myPage.MarginPreferences.Left
		myX2 = myPage.MarginPreferences.Right
	End If
	myY1 = myPage.marginPreferences.Top
	myX2 = myPageWidth - myX2
	myY2 = myPageHeight - myPage.MarginPreferences.Bottom
	myGetBounds = Array(myY1, myX1, myY2, myX2)
End Function
Rem ![Create a text frame within margins - functions.]