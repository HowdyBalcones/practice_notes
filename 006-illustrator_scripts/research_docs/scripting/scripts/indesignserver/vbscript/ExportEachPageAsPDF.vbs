Rem ExportEachPageAsPDF.vbs
Rem An InDesign Server VBScript
Rem Exports each page of an InDesign document as a separate PDF to
Rem a specified folder using the current PDF export settings.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myFileSystemObject = CreateObject("Scripting.FileSystemObject")
If myInDesignServer.Documents.Count <> 0 Then
    Set myDocument = myInDesignServer.Documents.Item(1)
    Rem Fill in a valid file path on your system.
    myFolderPath = "c:\ServerTestFiles"
    If Not myFileSystemObject.FolderExists(myFolderPath) Then
        filesys.CreateFolder(myFolderPath)
    End If
    If myFileSystemObject.FolderExists(myFolderPath) Then
        myExportPages myInDesignServer, myDocument, myFolderPath
    End If
Else
    returnValue = "No documents are open."
End If

Function myExportPages(myInDesignServer, myDocument, myFolderName)
    myBaseName = myDocument.Name
    For myCounter = 1 To myDocument.Pages.Count
        myPageName = myDocument.Pages.Item(myCounter).Name
        myInDesignServer.PDFExportPreferences.PageRange = myPageName
        Rem Generate a file path from the folder name, the base document name, and the page name.
        Rem Replace the colons in the page name (e.g., "Sec1:1") wtih underscores.
        myPageName = Replace(myPageName, ":", "_")
        myFilePath = myFolderName & "\" & myBaseName & "_" & myPageName & ".pdf"
        myDocument.Export idExportFormat.idPDFType, myFilePath
    Next
End Function