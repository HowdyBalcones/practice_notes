Rem SaveDocument.vbs
Rem An InDesign Server VBScript
Rem If the active document has been changed since it was last saved, save it.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    If myInDesignServer.Documents.Item(1).Modified = True Then
        myInDesignServer.Documents.Item(1).Save
    Else
        returnValue = "Document not saved because it hasn't been modified."
    End If
Else
    returnValue = "No documents are open."
End If
