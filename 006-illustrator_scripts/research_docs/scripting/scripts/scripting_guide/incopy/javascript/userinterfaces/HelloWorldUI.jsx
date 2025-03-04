//HelloWorldDialog.jsx
//An InCopy CS3 JavaScript
//
//Adds a simple dialog box to the HelloWorld script.
var myDialog = app.dialogs.add({name:"Simple User Interface Example Script",canCancel:true});
with(myDialog){
	//Add a dialog column.
	with(dialogColumns.add()){
		//Create a text edit field.
		var myTextEditField = textEditboxes.add({editContents:"Hello World!",
		minWidth:180});
		//Create a number (real) entry field.
		var myPointSizeField = realEditboxes.add({editValue:72});
	}
}
//Display the dialog box.
var myResult = myDialog.show();
if(myResult == true){
	//Get the values from the dialog box controls.
	var myString = myTextEditField.editContents;
	var myPointSize = myPointSizeField.editValue;
	//Remove the dialog box from memory.
	myDialog.destroy();
	//Create a new document.
	var myDocument = app.documents.add()
	with(myDocument){
		var myStory = myDocument.stories.item(0);
		//Enter the text from the dialog box.
		myStory.contents=myString;
		//Set the size of the text to the size you entered in the dialog box.
		myStory.texts.item(0).pointSize = myPointSize;
	}
}
else{
	//User clicked Cancel, so remove the dialog box from memory.
	myDialog.destroy();
}
