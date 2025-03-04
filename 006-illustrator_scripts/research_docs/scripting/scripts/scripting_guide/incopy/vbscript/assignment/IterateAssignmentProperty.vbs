Rem IterateAssignmentProperty.vbs
Rem An InCopy VBScript
Rem 
Rem Iterating assignment properties

Rem



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
  Set myDocument = myInCopy.Documents.Item(1)
  
  Set myAssignement = myDocument.Assignments.Item(1)
  myUserName = myAssignement.UserName
  myFilePath = myAssignement.FilePath
  myDocPath =  myAssignement.DocumentPath
  myFramecolor = myAssignement.FrameColor
  myincludeLinksWhenPackage =myAssignement.IncludeLinksWhenPackage
  
  Rem Export options for assignment files.
  Rem AssignmentExportOptions.ASSIGNED_SPREADS Exports only spreads with assigned frames
  Rem AssignmentExportOptions.EMPTY_FRAMES  Exports frames but does not export content
  Rem AssignmentExportOptions.EVERYTHING   Exports the entire document.
  myExportOptions =  myAssignement.ExportOptions
End Function
Function myTeardown(myInCopy)
End Function

