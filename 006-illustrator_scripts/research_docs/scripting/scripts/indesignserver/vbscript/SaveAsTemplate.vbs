Rem SaveAsTemplate.vbs
Rem An InDesign Server VBScript
Rem Save the current document as a template.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    Set myDocument = myInDesignServer.Documents.Item(1)
    If myDocument.Saved = True Then
        Rem Convert the file name to a string.
        myFileName = myDocument.FullName
        Rem If the file name contains the extension ".indd", change it to ".indt".
        If InStr(1, myFileName, ".indd") <> 0 Then
            myFileName = Replace(myFileName, ".indd", ".indt")
        End If
    Else
        Rem If the document has not been saved, then give it a
        Rem default file name/file path.
        Set filesys = CreateObject("Scripting.FileSystemObject")
        myFolderPath = "c:\ServerTestFiles"
        If Not filesys.FolderExists(myFolderPath) Then
            filesys.CreateFolder(myFolderPath)
        End If
        myFileName = myFolderPath & "\" & "myTestDocument.indt"
    End If
    
    Set myDocument = myDocument.Save(myFileName, True)
    
    Rem Close the document
    myDocument.Close
Else
    returnValue = "No documents are open."
End If
