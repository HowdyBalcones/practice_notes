Rem HelloWorld.vbs
Rem An InDesign VBScript
Rem
Set myInDesign = CreateObject("InDesign.Application.2024")
Set myDocument = myInDesign.Documents.Add
Set myTextFrame = myDocument.Pages.Item(1).TextFrames.Add
myTextFrame.GeometricBounds = Array("6p", "6p", "24p", "24p")
myTextFrame.Contents = "Hello World!"