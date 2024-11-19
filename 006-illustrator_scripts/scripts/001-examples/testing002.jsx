// var newDoc = app.documents.add(DocumentColorSpace.RGB, 800, 600)
var doc = app.activeDocument;
var rect = doc.pathItems.rectangle(300, 200, 100, 200);
var artboardBounds = [100, -100, 500, -400];

var docArtboards = doc.artboards.add(artboardBounds);
docArtboards.name = "New Artboard";

rect.fillColor = new RGBColor();
rect.fillColor.red = 255;
rect.fillColor.green = 135;
rect.fillColor.blue = 75;
alert('Rectangle created!');
