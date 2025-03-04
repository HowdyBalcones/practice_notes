Rem HelloWorld.vbs
Set myInDesignServer = CreateObject("InDesignServer.Application")
Rem Create a new document.
Set myDocument = myInDesignServer.Documents.Add
Rem Get a reference to the first page.
Set myPage = myDocument.Pages.Item(1)
Rem Create a text frame.
Set myTextFrame = myPage.TextFrames.Add
Rem Specify the size and shape of the text frame.
myTextFrame.GeometricBounds = Array("6p0", "6p0", "18p0", "18p0")
Rem Enter text in the text frame.
myTextFrame.Contents = "Hello World!"
Rem Save the document (fill in a valid file path).
myDocument.Save "c:\HelloWorld.indd"
Rem Close the document.
myInDesignServer.Documents.Item(1).Close
