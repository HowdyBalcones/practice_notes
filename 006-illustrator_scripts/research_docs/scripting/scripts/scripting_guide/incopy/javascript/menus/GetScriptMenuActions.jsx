//GetScriptMenuActions.jsx
//An InCopy JavaScript
//
//Gets the names of all menu actions and writes them to a text file.
main();
function main(){
	mySetup();
	mySnippet()
	myTeardown()
}
function mySetup(){
}
function mySnippet(){
	//<fragment>
	var myScriptMenuActionNames = app.menuActions.everyItem().name;
	//Open a new text file.so
	var myTextFile = File.saveDialog("Save Script Menu Action Names As", undefined);
	//If the user clicked the Cancel button, the result is null.
	if(myTextFile != null){
		//Open the file with write access.
		myTextFile.open("w");
		for(var myCounter = 0; myCounter < myScriptMenuActionNames.length; myCounter++){
			myTextFile.writeln(myScriptMenuActionNames[myCounter]);
			//To add a list of key strings for each menuAction, comment out the
			//line above and uncomment the lines below.s
			//myKeyString = app.findKeyStrings(myMenuActionNames[myCounter]);
			//myTextFile.writeln(myMenuActionNames[myCounter] + "\tKey Strings: " + myKeyString);
		}
		myTextFile.close();
	}
	//</fragment>
}
function myTeardown(){
}
