//ViewPreferences.jsx
//An InDesign Server JavaScript
//Changes the measurement units used by the active document.
//Assumes you have a document open.

var result = "No documents are open.";
if(app.documents.length > 0) {
	var myDocument = app.documents.item(0);
	with(myDocument.viewPreferences){
		//Measurement unit choices are:
		//* idMeasurementUnits.idPicas
		//* idMeasurementUnits.idPoints
		//* idMeasurementUnits.idInches
		//* idMeasurementUnits.idInchesDecimal
		//* idMeasurementUnits.idMillimeters
		//* idMeasurementUnits.idCentimeters
		//* idMeasurementUnits.idCiceros
		//* idMeasurementUnits.idCustom
		//InDesign J additional measurement units:
		//* idMeasurementUnits.idAmericanPoints
		//* idMeasurementUnits.idHa
		//* idMeasurementUnits.idQ
		//If you set the the vertical or horizontal measurement units
		//to idMeasurementUnits.idCustom, you can also set a custom
		//ruler increment (in points) using:
		//.HorizontalCustomPoints = 15
		//.VerticalCustomPoints = 15
		//Set horizontal and vertical measurement units to points.
		horizontalMeasurementUnits = MeasurementUnits.points;
		verticalMeasurementUnits = MeasurementUnits.points;
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
}
result;