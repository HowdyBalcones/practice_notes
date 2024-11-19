
var doc = app.activeDocument;
doc.rulerUnits = RulerUnits.Inches;

var rect = doc.pathItems.rectangle(200,200,100,100);
var circle = doc.pathItems.ellipse(400,400,100,100);

var Rfill = new RGBColor();


function fillRed() {

Rfill.red = 255;
Rfill.green = 0;
Rfill.blue = 0;
rect.fillColor = Rfill; 
circle.fillColor =Rfill;
}

fillRed();
