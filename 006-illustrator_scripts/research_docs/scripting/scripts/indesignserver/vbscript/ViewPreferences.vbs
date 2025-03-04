Rem ViewPreferences.vbs
Rem An InDesign Server VBScript
Rem Changes the measurement units used by the active document.
Rem Assumes you have a document open.
Set myInDesignServer = CreateObject("InDesignServer.Application")
If myInDesignServer.Documents.Count > 0 Then
    Set myDocument = myInDesignServer.Documents.Item(1)
    With myDocument.ViewPreferences
        Rem Measurement unit choices are:
        Rem * idMeasurementUnits.idPicas
        Rem * idMeasurementUnits.idPoints
        Rem * idMeasurementUnits.idInches
        Rem * idMeasurementUnits.idInchesDecimal
        Rem * idMeasurementUnits.idMillimeters
        Rem * idMeasurementUnits.idCentimeters
        Rem * idMeasurementUnits.idCiceros
        Rem * idMeasurementUnits.idCustom
        Rem InDesign J additional measurement units:
        Rem * idMeasurementUnits.idAmericanPoints
        Rem * idMeasurementUnits.idHa
        Rem * idMeasurementUnits.idQ
        Rem If you set the the vertical or horizontal measurement units
        Rem to idMeasurementUnits.idCustom, you can also set a custom
        Rem ruler increment (in points) using:
        Rem .HorizontalCustomPoints = 15
        Rem .VerticalCustomPoints = 15
        Rem Set horizontal and vertical measurement units to points.
        .HorizontalMeasurementUnits = idMeasurementUnits.idPoints
        .VerticalMeasurementUnits = idMeasurementUnits.idPoints
    End With

    Rem Save the file (fill in a valid file path on your system).
    If myDocument.Saved = False Then
        Set filesys = CreateObject("Scripting.FileSystemObject")
        myFolderPath = "c:\ServerTestFiles"
        If Not filesys.FolderExists(myFolderPath) Then
            filesys.CreateFolder(myFolderPath)
        End If
        Set myDocument = myDocument.Save(myFolderPath & "\" & "myTestDocument.indd")
    End If
Else
    returnValue = "No documents are open."
End If
