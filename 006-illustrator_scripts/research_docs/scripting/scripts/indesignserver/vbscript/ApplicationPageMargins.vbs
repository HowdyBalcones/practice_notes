Rem ApplicationPageMargins.vbs
Rem An InDesign Server VBScript
Rem Sets the application default page margins. All new documents
Rem will be created using these settings. Existing documents
Rem will be unaffected.
Set myInDesignServer = CreateObject("InDesignServer.Application")
With myInDesignServer.MarginPreferences
    Rem Save the current application default margin preferences.
    myY1 = .Top
    myX1 = .Left
    myY2 = .Bottom
    myX2 = .Right
    Rem Set the application default margin preferences.
    .Top = 0
    .Left = 0
    .Bottom = 0
    .Right = 0
End With

Rem Create a new example document to demonstrate the change.
Set myDocument = myInDesignServer.Documents.Add
myDocument.DocumentPreferences.PageHeight = "1p"
myDocument.DocumentPreferences.PageWidth = "6p"

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close

Rem Reset the application default margin preferences to their former state.
With myInDesignServer.MarginPreferences
    .Top = myY1
    .Left = myX1
    .Bottom = myY2
    .Right = myX2
End With