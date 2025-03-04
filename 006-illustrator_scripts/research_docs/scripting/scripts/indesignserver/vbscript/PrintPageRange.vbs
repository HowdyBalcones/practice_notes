Rem PrintPageRange.vbs
Rem An InDesign Server VBScript
Rem Prints a page range from the active document.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Rem Create an example document.
Set myDocument = myInDesignServer.Documents.Add
myDocument.ViewPreferences.RulerOrigin = idRulerOrigin.idPageOrigin
myPageHeight = myDocument.DocumentPreferences.PageHeight
myPageWidth = myDocument.DocumentPreferences.PageWidth
myDocument.DocumentPreferences.PagesPerDocument = 10
Set myMasterSpread = myDocument.MasterSpreads.Item(1)
Set myTextFrame = myMasterSpread.Pages.Item(1).TextFrames.Add
myTextFrame.GeometricBounds = Array(0, 0, myPageHeight, myPageWidth)
myTextFrame.Contents = idSpecialCharacters.idAutoPageNumber
myTextFrame.Paragraphs.Item(1).Justification = idJustification.idCenterAlign
myTextFrame.Paragraphs.Item(1).PointSize = 72
myTextFrame.TextFramePreferences.VerticalJustification = idVerticalJustification.idCenterAlign
Set myTextFrame = myMasterSpread.Pages.Item(2).TextFrames.Add
myTextFrame.GeometricBounds = Array(0, 0, myPageHeight, myPageWidth)
myTextFrame.Contents = idSpecialCharacters.idAutoPageNumber
myTextFrame.Paragraphs.Item(1).Justification = idJustification.idCenterAlign
myTextFrame.Paragraphs.Item(1).PointSize = 72
myTextFrame.TextFramePreferences.VerticalJustification = idVerticalJustification.idCenterAlign
For myCounter = 1 To myDocument.Pages.Count
    myDocument.Pages.Item(myCounter).AppliedMaster = myDocument.MasterSpreads.Item("A-Master")
Next
Rem End of example document setup.
Rem The page range can be either idPageRange.idAllPages or a page range string.
Rem A page number entered in the page range must correspond to a page
Rem name in the document (i.e., not the page index). If the page name is
Rem not found, InDesignServer will generate an error.
myDocument.PrintPreferences.PageRange = "1-3, 6, 9"
myDocument.PrintOut

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close
