Rem CreateGuides.vbs
Rem An InDesign Server VBScript
Rem Add a series of guides using the createGuides method.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
Rem Parameters (all optional): row count, column count, row gutter,
Rem column gutter,guide color, fit margins, remove existing, layer.
Rem Note that the createGuides method does not take an RGB array
Rem for the guide color parameter.
myDocument.Spreads.Item(1).CreateGuides 4, 4, "1p", "1p", idUIColors.idGray, True, True, myDocument.Layers.Item(1)

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close