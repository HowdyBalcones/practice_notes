//ExportPDF.jsx
//An InDesign Server JavaScript
//Exports the current document as PDF.
//Assumes you have a document open.
//document.exportFile parameters are:
//Format: use either the ExportFormat.pdfType constant or the string "Adobe PDF"
//To: a file path as a string
//Using: PDF export preset (or a string that is the name of a PDF export preset)
//The default PDF export preset names are surrounded by square brackets (e.g., "[Screen]").

var result = "No documents are open.";
if(app.documents.length > 0){
	var myFile = new File("/c/ServerTestFiles/myTestDocument.pdf");
	var result = "exported to:  " + myFile.fullName;
	if(!myFile.parent.exists && !myFile.parent.create()) {
		result = "Not exported.  Unable to create the folder:  " + myFile.parent.fullName;
	} else {
		app.documents.item(0).exportFile(ExportFormat.pdfType, myFile, app.pdfExportPresets.item("[Press Quality]"));
	}
}

result;