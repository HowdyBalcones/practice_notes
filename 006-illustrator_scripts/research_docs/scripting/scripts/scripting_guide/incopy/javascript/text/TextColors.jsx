//TextColors.jsx
//An InCopy JavaScript
//
//Shows how to apply colors to the fill and stroke of text.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	var myColorA, myColorB, myName;
	//Create an example document.
	var myDocument = app.documents.add();
	//Create a color.
	try{
		myColorA = myDocument.colors.item("DGC1_664a");
		//If the color does not exist, trying to get its name will generate an error.
		myName = myColorA.name;
	}
	catch (myError){
		//The color style did not exist, so create it.
		myColorA = myDocument.colors.add({name:"DGC1_664a", model:ColorModel.process, colorValue:[90, 100, 70, 0]});
	}
	//Create another color.
	try{
		myColorB = myDocument.colors.item("DGC1_664b");
		//If the color does not exist, trying to get its name will generate an error.
		myName = myColorB.name;
	}
	catch (myError){
		//The color style did not exist, so create it.
		myColorB = myDocument.colors.add({name:"DGC1_664b", model:ColorModel.process, colorValue:[70, 0, 30, 50]});
	}
	var myStory = myDocument.stories.item(0);
	//Enter text in the text frame.
	myStory.contents = "Text\rColor"
}
function mySnippet(){
	//<fragment>
	var myDocument = app.documents.item(0);
	var myColorA = myDocument.colors.item("DGC1_664a");
	var myColorB = myDocument.colors.item("DGC1_664b");
	var myStory = app.documents.item(0).stories.item(0);
	var myText = myStory.paragraphs.item(0)
	myText.pointSize = 72;
	myText.justification = Justification.centerAlign;
	//Apply a color to the fill of the text.
	myText.fillColor = myColorA;
	//Use the itemByRange method to apply the color to the stroke of the text.
	myText.strokeColor = myColorB;
	var myText = myStory.paragraphs.item(1)
	myText.strokeWeight = 3;
	myText.pointSize = 144;
	myText.justification = Justification.centerAlign;
	myText.fillColor = myColorB;
	myText.strokeColor = myColorA;
	myText.strokeWeight = 3;
	//</fragment>
}
function myTeardown(){
}
