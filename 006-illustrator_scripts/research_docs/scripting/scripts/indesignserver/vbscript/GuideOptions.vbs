Rem GuideOptions.vbs
Rem An InDesign Server VBScript
Rem Shows how to set guide options.
Set myInDesignServer = CreateObject("InDesignServer.Application")
Set myDocument = myInDesignServer.Documents.Add
Rem Create a layer named "guide layer".
Set myLayer = myDocument.Layers.Add
myLayer.Name = "guide layer"
Rem Add a series of guides to page 1.
With myDocument.Pages.Item(1)
    Rem Create a guide on the layer we created above.
    With .Guides.Add(myLayer)
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = "12p"
    End With
    Rem Another way to make a guide on a specific layer.
    With .Guides.Add()
        .ItemLayer = myLayer
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = "14p"
    End With
    Rem Make a locked guide.
    With .Guides.Add()
        .ItemLayer = myLayer
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = "16p"
        .Locked = True
    End With
    Rem Set the view threshold of a guide.
    With .Guides.Add()
        .ItemLayer = myLayer
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = "18p"
        .ViewThreshold = 100
    End With
    Rem Set the guide color of a guide using a UIColors constant.
    With .Guides.Add()
        .ItemLayer = myLayer
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = "18p"
        .GuideColor = idUIColors.idGray
    End With
    Rem Set the guide color of a guide using an RGB array.
    With .Guides.Add()
        .ItemLayer = myLayer
        .Orientation = idHorizontalOrVertical.idHorizontal
        .Location = "22p"
        .GuideColor = Array(192, 192, 192)
    End With
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
