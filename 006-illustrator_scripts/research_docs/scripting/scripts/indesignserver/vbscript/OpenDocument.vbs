Rem OpenDocument.vbs
Rem An InDesign Server VBScript
Rem Opens an existing document. You'll have to fill in your own file path.

Set myInDesignServer = CreateObject("InDesignServer.Application")

Set filesys = CreateObject("Scripting.FileSystemObject")
myFilePath = "c:\ServerTestFiles\myTestDocument.indd"
If Not filesys.FileExists(myFilePath) Then
    myFolderPath = "c:\ServerTestFiles"
    If Not filesys.FolderExists(myFolderPath) Then
        filesys.CreateFolder(myFolderPath)
    End If
    Rem Create the document, save it, and close it
    Set myDocument = myInDesignServer.Documents.Add
    Set myDocument = myDocument.Save(myFilePath)
    myDocument.Close
End If

Rem OPEN
Set myDocument = myInDesignServer.Open(myFilePath)

Rem Add a rectangle to the first page.
Set myRectangle = myDocument.Pages.Item(1).Rectangles.Add
myRectangle.GeometricBounds = Array("6p", "6p", "18p", "18p")
myRectangle.StrokeWeight = 12

Rem Leave document file open...

returnValue = myDocument.FullName