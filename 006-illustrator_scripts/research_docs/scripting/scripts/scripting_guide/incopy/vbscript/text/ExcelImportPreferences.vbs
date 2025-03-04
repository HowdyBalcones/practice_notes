Rem ExcelImportPreferences.vbs
Rem An InCopy VBScript
Rem
Rem Sets the Excel import filter preferences.
main
Function main()
	Set myInCopy = CreateObject("InCopy.Application.2024")
	mySetup myInCopy
	mySnippet myInCopy
	myTeardown myInCopy
End Function
Function mySetup(myInCopy)
End Function
Function mySnippet(myInCopy)
	With myInCopy.ExcelImportPreferences
		Rem alignmentStyle property can be:
		Rem AlignmentStyleOptions.centerAlign
		Rem AlignmentStyleOptions.leftAlign
		Rem AlignmentStyleOptions.rightAlign
		Rem AlignmentStyleOptions.spreadsheet
		.AlignmentStyle = idAlignmentStyleOptions.idSpreadsheet
		.DecimalPlaces = 4
		.PreserveGraphics = False
		Rem Enter the range you want to import as "start cell:end cell".
		.RangeName = "A1:B16"
		.SheetIndex = 1
		.SheetName = "pathpoints"
		.ShowHiddenCells = False
		Rem tableFormatting property can be:
		Rem idTableFormattingOptions.idExcelFormattedTable
		Rem idTableFormattingOptions.idExcelUnformattedTabbedText
		Rem idTableFormattingOptions.idExcelUnformattedTable
		.TableFormatting = idTableFormattingOptions.idExcelFormattedTable
		.UseTypographersQuotes = True
		.ViewName = ""
	End With
End Function
Function myTeardown(myInCopy)
End Function
