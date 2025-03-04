Rem PrintDocument.vbs
Rem An InDesign Server VBScript
Rem Prints the active document.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    Rem The PrintOut method has one optional parameter, Using,
    Rem which sets the printer preset to use. The following line
    Rem prints the document using the default settings
    myInDesignServer.Documents.Item(1).PrintOut
    Rem To print the document using a preset named "ColorProof":
    Rem myInDesignServer.Documents.Item(1).PrintOut "ColorProof"
Else
    returnValue = "No documents are open."
End If