Rem OnIdleEventHandler.vbs
Rem An InDesign VBScript
Rem
Rem A script which will be run when InDesign is idle.

Rem ![On idle event handler.]
Rem "evt" is the event passed to this script by the event listener.
onIdleEventHandler(evt)
Function onIdleEventHandler(myIdleEvent)
	Set myInDesign = CreateObject("InDesign.Application.2024")
	If myInDesign.Documents.Count = 0 Then
		Set myDoc = myInDesign.Documents.Add()
		MsgBox("Created document " + myDoc.Name + " in idle task.")
		Exit Function
	End If

	Set myTextFrames = myInDesign.ActiveDocument.Pages.Item(1).TextFrames
	If myTextFrames.Count = 0 Then
		Set myTextFrame = myTextFrames.Add()
		myTextFrame.GeometricBounds = Array("72pt", "72pt", "288pt", "288pt")
		myTextFrame.Contents = "Text frame created in idle task"
		MsgBox("Created a text frame in idle task.")
		Exit Function
	End If

	Rem Delete idle task by setting its sleep time to zero.
	myIdleEvent.Parent.Sleep = 0
	MsgBox("Nothing to do. Delete idle task.")
End Function
Rem ![On idle event handler.]
