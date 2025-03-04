//TextSelection.jsx
//An InCopy JavaScript
//
//Shows how to determine whether the current selection is a text selection.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	//<fragment>
	//Check to see if any documents are open.
	if (app.documents.length != 0){
		//If the selection contains more than one item, the selection
		//is not text selected with the Type tool.
		if (app.selection.length != 0){
			//Evaluate the selection based on its type.
			switch (app.selection[0].constructor.name){
				case "InsertionPoint":
				case "Character":
				case "Word":
				case "TextStyleRange":
				case "Line":
				case "Paragraph":
				case "TextColumn":
				case "Text":
				case "Story":
					//The object is a text object; display the text object type.
					//A practical script would do something with the selection,
					//or pass the selection on to a function.
					alert("Selection is a " + app.selection[0].constructor.name);
					//If the selection is inside a note, the parent of the selection
					//will be a note object.
					if(app.selection[0].parent.constructor.name == "Note"){
					alert("Selection is inside a note.");
					}
					break;
				default:
					alert("The selected object is not a text object. Select some text and try again.");
				break;
			}
		}
		else{
			alert("Please select some text and try again.");
		}
	}
	else{
		alert("No documents are open.");
	}
	//</fragment>
}
function myTeardown(){
}