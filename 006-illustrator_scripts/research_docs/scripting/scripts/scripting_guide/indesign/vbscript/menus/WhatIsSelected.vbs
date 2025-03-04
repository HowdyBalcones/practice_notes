Rem WhatIsSelected.vbs
Rem An InDesign VBScript
Rem
Rem Provides a "onInvoke" event handler for the BeforeDisplay.vbs
Rem tutorial script. When invoked, display a message about the selection.
Set myInDesign = CreateObject("InDesign.Application.2024")
Rem ![What is selected.]
myString = TypeName(myInDesign.Selection.Item(1))
MsgBox "The first item in the selection is a " & myString & "."
Rem ![What is selected.]

