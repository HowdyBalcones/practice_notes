Rem ResetMeasurementUnits.vbs
Rem An InDesign Server VBScript
Rem Changes, then resets the active document's measurement units.
Rem Assumes you have a document open.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    Set myDocument = myInDesignServer.Documents.Item(1)
    With myDocument.ViewPreferences
        myOldXUnits = .HorizontalMeasurementUnits
        myOldYUnits = .VerticalMeasurementUnits
        .HorizontalMeasurementUnits = idMeasurementUnits.idPoints
        .VerticalMeasurementUnits = idMeasurementUnits.idPoints
    End With
    
    Rem ...At this point, you can perform any series of script actions that depend 
    Rem    on the measurement units you've set...
    
    Rem At the end of the script, reset the units to their original state.
    With myDocument.ViewPreferences
        .HorizontalMeasurementUnits = myOldXUnits
        .VerticalMeasurementUnits = myOldYUnits
    End With

Else
    returnValue = "No documents are open."
End If