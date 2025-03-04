//TextExportPreferences.jsx
//An InCopy JavaScript
//
//Sets the text export filter preferences.
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
	with(app.textExportPreferences){
		//Options for characterSet:
		//TextExportCharacterSet.utf8
		//TextExportCharacterSet.utf16
		//TextExportCharacterSet.defaultPlatform
		characterSet = TextExportCharacterSet.utf16;
		//platform options:
		//ImportPlatform.macintosh
		//ImportPlatform.pc
		platform = ImportPlatform.macintosh;
	}
	//</fragment>
}
function myTeardown(){
}
