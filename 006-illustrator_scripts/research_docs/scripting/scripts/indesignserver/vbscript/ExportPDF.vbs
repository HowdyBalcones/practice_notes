Rem ExportPDF.vbs
Rem An InDesign Server VBScript
Rem Exports the active document as PDF.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Rem Assumes you have a document open.
Rem Document.Export parameters are:
Rem Format: use either the idExportFormat.idPDFType constant or the string "Adobe PDF"
Rem To: a file path as a string
Rem Using: PDF export preset (or a string that is the name of a PDF export preset)
Rem The default PDF export preset names are surrounded by square brackets (e.g., "[Screen]").
If myInDesignServer.Documents.Count > 0 Then
    Set filesys = CreateObject("Scripting.FileSystemObject")
    myFolderPath = "c:\ServerTestFiles"
    If Not filesys.FolderExists(myFolderPath) Then
        filesys.CreateFolder(myFolderPath)
    End If
    myFile = myFolderPath & "\" & "myTestDocument.pdf"
    myInDesignServer.Documents.Item(1).Export idExportFormat.idPDFType, myFile, myInDesignServer.PDFExportPresets.Item("[Press Quality]")
Else
    returnValue = "No documents are open."
End If
