var doc = app.activeDocument;
var selectedItems = doc.selection;
var exportFile = new File("/Volumes/Graphics/Select III/003_Product_Images/000-Ingest");

var options = new ExportOptionsPNG24();
options.antiAliasing = true;
options.transparency = true;
options.artBoardClipping = true;

doc.exportFile(exportFile, ExportType.PNG24, options);

// 
