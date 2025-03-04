Rem CloseDocument.vbs
Rem An InDesign Server VBScript
Rem Closes the current document.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    myInDesignServer.Documents.Item(1).Close
Else
    returnValue = "No documents are open."
End If
