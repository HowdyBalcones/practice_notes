	Rem HelloWorld.vbs
Rem An InCopy VBScript
Rem
Set myInCopy = CreateObject("InCopy.Application.2024")
Set myDocument = myInCopy.Documents.Add
Set myStory = myDocument.Stories.Item(1)
myStory.Contents = "Hello World!"