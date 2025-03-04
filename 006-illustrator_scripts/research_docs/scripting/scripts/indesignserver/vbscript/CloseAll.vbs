Rem CloseAll.vbs
Rem An InDesign Server VBScript
Rem Closes all open documents without saving.
Set myInDesignServer = CreateObject("InDesignServer.Application")
For myCounter = myInDesignServer.Documents.Count To 1 Step -1
    myInDesignServer.Documents.Item(myCounter).Close idSaveOptions.idNo
Next