Rem PackageAssignment.vbs
Rem An InCopy VBScript
Rem 
Rem Create an InCopy package file

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
  If  myAssignement.Packaged = False Then
  Rem    idPackageType.idForwardPackage    Creates an assignment package for export.
  Rem    idPackageType.idReturnPackage     Creates an assignment package to place in the main document.
  myAssignement.CreatePackage "c:\b.icap",idPackageType.idForwardPackage
  End If
End Function
Function myTeardown(myInCopy)
End Function
