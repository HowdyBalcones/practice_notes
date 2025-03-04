Rem ApplyMasterToMaster.vbs
Rem An InDesign Server VBScript
Rem Applies a master page to a master page.
Rem Assumes that the default master spread name is "A-Master".
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
Rem Create a new master spread.
Set myBMaster = myDocument.MasterSpreads.Add
myBMaster.NamePrefix = "B"
myBMaster.BaseName = "Master"
Rem Apply master spread "A" to the first page of the new master spread.
myDocument.MasterSpreads.Item("B-Master").Pages.Item(1).AppliedMaster = myDocument.MasterSpreads.Item("A-Master")

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close