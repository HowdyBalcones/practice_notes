
var doc = app.activeDocument;

var sourceName = app.activeDocument.name;
var savePath = "/Volumes/Graphics/Select III/003_Product_Images/000-Ingest/";
var saveFile = new File(savePath + sourceName);

var options = new PDFSaveOptions();
options.acrobatLayers = true;
options.preserveEditability = true;
options.embedAllFonts = true;




function outlineTextFrames() {
	for (var i = doc.textFrames.length - 1; i >= 0; i--) {
		var textFrame = doc.textFrames[i];
		textFrame.createOutline();	
	}
}

function expandAllExceptText() {
	for (var i = doc.pageItems.length -1; i >= 0; i--) {
		var item = doc.pageItems[i];
		if (item.typename !== "TextFrame") {
			item.selected = true;
			// this runs actions inside illustrator app.doScript("ActionName", "ActionFolder", WithDialog?)
			app.doScript("Expand","Script Actions", false);
			item.selected = false;
		}
	}
}

function saveAsPDF() {
	doc.saveAs(saveFile, options);
}

outlineTextFrames();
//expandAllExceptText();
saveAsPDF();
