Rem ApplyMaster.vbs
Rem An InDesign Server VBScript
Rem Applies a master spread to a page.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
Rem Create a new master spread.
Set myMasterSpread = myDocument.MasterSpreads.Add
Rem Apply the new master spread to the first page in the document.
myDocument.Pages.Item(1).AppliedMaster = myMasterSpread
Rem When you are working with an existing document, you can refer to
Rem a master spread by name, for example: myDocument.MasterSpreads.Item("B-Master")

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close