Rem BeforeDisplayHandler.vbs
Rem An InDesign VBScript
Rem
Rem Provides a "beforeDisplay" event handler for the BeforeDisplay.vbs
Rem tutorial script. If one or more items are selected, enable the menu item. 
Rem ![Before display handler.]
Set myInDesign = CreateObject("InDesign.Application.2024")
Set mySampleScriptAction = myInDesign.ScriptMenuActions.Item("Display Message")
If myInDesign.Selection.Count > 0 Then
	mySampleScriptAction.Enabled = True
Else
	mySampleScriptAction.Enabled = False
End If
Rem ![Before display handler.]