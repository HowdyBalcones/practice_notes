//ResetMeasurementUnits.jsx
//An InDesign Server JavaScript
//Changes, then resets the active document’s measurement units.
//Assumes you have a document open.
var result = "No documents are open.";
if(app.documents.length > 0) {
	var myDocument = app.documents.item(0);
	
	with(myDocument.viewPreferences){
		myOldXUnits = horizontalMeasurementUnits;
		myOldYUnits = verticalMeasurementUnits;
		horizontalMeasurementUnits = MeasurementUnits.points;
		verticalMeasurementUnits = MeasurementUnits.points;
	}
	
	//...At this point, you can perform any series of script actions that depend on the measurement
	//units you’ve set. At the end of the script, reset the units to their original state.
	
	with(myDocument.viewPreferences){
			horizontalMeasurementUnits = myOldXUnits;
			verticalMeasurementUnits = myOldYUnits;
	}
	result = "success";
}
result;