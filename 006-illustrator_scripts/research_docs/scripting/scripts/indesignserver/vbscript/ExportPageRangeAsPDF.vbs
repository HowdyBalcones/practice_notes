Rem ExportPageRangeAsPDF.vbs
Rem An InDesign Server VBScript.
Rem Exports a range of pages to a PDF file.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Rem Enter the names of the pages you want to export in the following line.
Rem Note that the page name is not necessarily the index of the page in the
Rem document (e.g., the first page of a document whose page numbering starts
Rem with page 21 will be "21", not 1).
Rem Create an example document.
Set myDocument = myInDesignServer.Documents.Add
myDocument.ViewPreferences.RulerOrigin = idRulerOrigin.idPageOrigin
myDocument.DocumentPreferences.PagesPerDocument = 12
Set myMasterSpread = myDocument.MasterSpreads.Item(1)
For myCounter = 1 To myMasterSpread.Pages.Count
    Set myTextFrame = myMasterSpread.Pages.Item(myCounter).TextFrames.Add
    myTextFrame.Move , Array(1, 1)
    myTextFrame.Contents = idSpecialCharacters.idAutoPageNumber
    myTextFrame.Paragraphs.Item(1).PointSize = 72
    myTextFrame.Paragraphs.Item(1).Justification = idJustification.idCenterAlign
    myTextFrame.TextFramePreferences.FirstBaselineOffset = idFirstBaseline.idAscentOffset
    myTextFrame.TextFramePreferences.VerticalJustification = idVerticalJustification.idCenterAlign
    myTextFrame.GeometricBounds = myGetBounds(myDocument, myMasterSpread.Pages.Item(myCounter))
Next
Rem End example document setup.
myInDesignServer.PDFExportPreferences.PageRange = "1-3, 6, 9"

Rem Fill in your own file path.
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
myFile = myFolderPath & "\" & "myTestFile.pdf"
myDocument.Export idExportFormat.idPDFType, myFile

Function myGetBounds(myDocument, myPage)
    myPageWidth = myDocument.DocumentPreferences.PageWidth
    myPageHeight = myDocument.DocumentPreferences.PageHeight
    Set myMarginPreferences = myPage.MarginPreferences
    myLeft = myMarginPreferences.Left
    myTop = myMarginPreferences.Top
    myRight = myPageWidth - myMarginPreferences.Right
    myBottom = myPageHeight - myMarginPreferences.Bottom
    myGetBounds = Array(myTop, myLeft, myBottom, myRight)
End Function
