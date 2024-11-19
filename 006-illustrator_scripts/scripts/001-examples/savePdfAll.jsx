var doc = app.activeDocument;
var saveFile = new File("/Volumes/Graphics/Select III/003_Product_Images/000-Ingest");

var options = new PDFSaveOptions();
options.acrobatLayers = true;
options.preserveEditability = true;

if (app.documents.length > 0) 
{
	for (var i = 0; i < app.documents.length; i++) {
		var currentDoc = app.documents[i];
		doc.saveAs(saveFile, options);
	}
} else {
	alert("No Documents are open.")
}
