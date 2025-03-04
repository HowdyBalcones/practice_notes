Rem MetadataExample.vbs
Rem An InDesign Server VBScript
Rem Adds metadata to an example document.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
With myDocument.MetadataPreferences
    .Author = "Olav Martin Kvern"
    .CopyrightInfoURL = "http://www.adobe.com"
    .CopyrightNotice = "This document is copyrighted."
    .CopyrightStatus = idCopyrightStatus.idYes
    .Description = "Example of xmp metadata scripting in InDesign"
    .DocumentTitle = "XMP Example"
    .JobName = "XMP_Example_2004"
    .Keywords = Array("animal", "mineral", "vegetable")
    Rem The metadata preferences object also includes the read-only
    Rem creator, format, creationDate, modificationDate, and serverURL properties that are
    Rem automatically entered and maintained by InDesign.
    Rem Create a custom XMP container, "email"
    .CreateContainerItem "http://ns.adobe.com/xap/1.0/", "email"
    .SetProperty "http://ns.adobe.com/xap/1.0/", "email/*[1]", "okvern@adobe.com"
End With

Rem Save the file (fill in a valid file path on your system).
Set filesys = CreateObject("Scripting.FileSystemObject")
myFolderPath = "c:\ServerTestFiles"
If Not filesys.FolderExists(myFolderPath) Then
    filesys.CreateFolder(myFolderPath)
End If
Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")

Rem Close the document
myDocument.Close