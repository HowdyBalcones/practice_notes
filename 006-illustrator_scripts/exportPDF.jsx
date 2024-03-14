var doc = app.activeDocument;
var saveFile = new File("/Volumes/Graphics/Select III/003_Product_Images/000-Ingest");

var options = new PDFSaveOptions();
options.acrobatLayers = true;
options.preserveEditability = true;

doc.saveAs(saveFile, options);

// Document.saveAs();
// PDFSaveOptions();
//
