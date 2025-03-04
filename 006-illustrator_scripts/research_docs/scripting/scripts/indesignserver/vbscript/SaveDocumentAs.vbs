Rem SaveDocumentAs.vbs
Rem An InDesign VBScript
Rem If the active document has not been saved (ever), save it.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    If myInDesignServer.Documents.Item(1).Saved = False Then
        Set filesys = CreateObject("Scripting.FileSystemObject")
        myFolderPath = "c:\ServerTestFiles"
        If Not filesys.FolderExists(myFolderPath) Then
            filesys.CreateFolder(myFolderPath)
        End If
        myInDesignServer.Documents.Item(1).Save(myFolderPath & "\" & "myTestDocument.indd")
    End If
Else
    returnValue = "No documents are open."
End If
