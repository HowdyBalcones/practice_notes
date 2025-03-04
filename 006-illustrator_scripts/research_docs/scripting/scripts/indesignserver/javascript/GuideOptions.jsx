//GuideOptions.jsx
//An InDesign Server JavaScript
//Shows how to set guide options.
var myDocument = app.documents.add();
//Create a layer named "guide layer".
var myLayer = myDocument.layers.add();
myLayer.name = "guide layer";
//Add a series of guides to page 1.
with(myDocument.pages.item(0)){
	//Create a guide on the layer we created above.
 	with(guides.add(myLayer)){
		orientation = HorizontalOrVertical.horizontal;
		location = "12p";
	}
	//Another way to make a guide on a specific layer.
	with(guides.add()){
		itemLayer = myLayer;
		orientation = HorizontalOrVertical.horizontal;
		location = "14p";
	}
	//Make a locked guide.
	with(guides.add()){
		itemLayer = myLayer;
		orientation = HorizontalOrVertical.horizontal;
		location = "16p";
		locked = true;
	}
	//Set the view threshold of a guide.
	with(guides.add()){
		itemLayer = myLayer;
		orientation = HorizontalOrVertical.horizontal;
		location = "18p";
		viewThreshold = 100;
	}
	//Set the guide color of a guide using a UIColors constant.
	with(guides.add()){
		itemLayer = myLayer;
		orientation = HorizontalOrVertical.horizontal;
		location = "18p";
		guideColor = UIColors.gray;
	}
	//Set the guide color of a guide using an RGB array.
	with(guides.add()){
		itemLayer = myLayer;
		orientation = HorizontalOrVertical.horizontal;
		location = "22p";
		guideColor = [192, 192, 192];
	}
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