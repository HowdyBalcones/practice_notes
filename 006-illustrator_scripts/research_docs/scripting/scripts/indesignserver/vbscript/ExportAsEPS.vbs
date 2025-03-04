Rem ExportAsEPS.vbs
Rem An InDesign Server VBScript.
Rem Exports the pages of the active document as a series of EPS files.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    Set filesys = CreateObject("Scripting.FileSystemObject")
    myFolderPath = "c:\ServerTestFiles"
    If Not filesys.FolderExists(myFolderPath) Then
        filesys.CreateFolder(myFolderPath)
    End If
    myInDesignServer.Documents.Item(1).Export idExportFormat.idEPSType, myFolderPath & "\" & "myTestFile.eps"
Else
    returnValue = "No documents are open."
End If
