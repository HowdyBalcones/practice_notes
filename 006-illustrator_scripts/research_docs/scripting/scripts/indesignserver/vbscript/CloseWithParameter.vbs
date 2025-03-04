Rem CloseWithParameter.vbs
Rem An InDesign Server VBScript
Rem Use idSaveOptions.idYes to save the document, or use idSaveOptions.idNo
Rem to close the document without saving. If you use idSaveOptions.idYes,
Rem you'll need to provide a reference to a file to save to in the second
Rem parameter (SavingIn).
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
     Set myDocument = myInDesignServer.Documents.Item(1)
     Rem If the file has not been saved, save it to a specific file path.
     If myDocument.Saved = False Then
        Set filesys = CreateObject("Scripting.FileSystemObject")
        myFolderPath = "c:\ServerTestFiles"
        If Not filesys.FolderExists(myFolderPath) Then
            filesys.CreateFolder(myFolderPath)
        End If
        myFilePath = myFolderPath & "\" & "myTestDocument.indd"
        myDocument.Close idSaveOptions.idYes, myFilePath
    Else
        Rem If the file has already been saved, save it.
        myDocument.Close idSaveOptions.idYes
    End If
Else
    returnValue = "No documents are open."
End If