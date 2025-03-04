//GuideAndGridPreferences.jsx
//An InDesign Server JavaScript
//Sets preferences for guides and grids.
//Assumes you have a document open.
var myDocument = app.documents.add();
with(myDocument.guidePreferences){
	guidesInBack = true;
	guidesLocked = false;
	guidesShown = true;
	//Objects "snap" to the guides (in InDesign) when
	//guidePreferences.guideSnapto is set to true.
	guidesSnapto = true;
}
with(myDocument.gridPreferences){
	documentGridShown = false;
	//Objects "snap" to the document grid (in InDesign) when
	//gridPreferences.documentGuideSnapto is set to true.
	documentGridSnapto = true;
	baselineGridShown = true;
	//Objects "snap" to the baseline grid (in InDesign) when
	//gridPreferences.guideSnapTo is set to true.
	baselineGridSnapto = true;
}
//Save the file (fill in a valid file path on your system).
var myFile = new File("/c/ServerTestFiles/myTestDocument.indd");
var result = "saved to:  " + myFile.fullName;
if(!myFile.parent.exists && !myFile.parent.create()) {
	result = "Not saved.  Unable to create the folder:  " + myFile.parent.fullName;
} else {
	myDocument = myDocument.save(myFile);
}

//Close the document
myDocument.close();

result;