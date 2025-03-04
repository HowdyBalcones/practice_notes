Rem ListOpenDocuments.vbs
Rem An InDesign Server VBScript
Rem Outputs the open documents
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    myOutput = ""
    For myCounter = 1 to myInDesignServer.Documents.Count Step 1
        myOutput = myOutput & VBCrLf & "[" & myCounter & "]  " & myInDesignServer.Documents.Item(myCounter).Name
    Next
    returnValue = myOutput
Else
    returnValue = "No documents are open."
End If
