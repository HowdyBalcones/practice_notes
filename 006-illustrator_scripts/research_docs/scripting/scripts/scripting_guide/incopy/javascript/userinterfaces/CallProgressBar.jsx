//CallProgressBar.jsx
//An InCopy CS3 JavaScript
//
//Shows how to diplay a progress bar created using ScriptUI.
//(Assumes that the ProgressBar.jsx script has already been run.)
#targetengine "session"
myCreateProgressPanel(20, 400);
myProgressPanel.show();
var myStory = app.documents.item(0).stories.item(0);
for(var myCounter = 0; myCounter < 20; myCounter ++){
	//Scale the value change to the maximum value of the progress bar.
	myProgressPanel.myProgressBar.value = myCounter/myIncrement;
	var myInsertionPoint = myStory.insertionPoints.item(-1);
	myInsertionPoint.contents = "This is a paragraph\r.";
}
myProgressPanel.myProgressBar.value = 0;
myProgressPanel.hide();
