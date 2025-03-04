Set myInCopy = CreateObject("InCopy.Application.2024")
Set myDocument = myInCopy.Documents.Item(1)
myInCopy.UserName = "Someone"
myDocument.MetadataPreferences.Author = "Adobe Systems"
myDocument.MetadataPreferences.Description = "This is a sample document with XMP metadata."