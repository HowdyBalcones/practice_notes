//TranslateKeyString.jsx
//An InCopy JavaScript
//
//Translates a key string (a locale-independent string) into the corresponding
//string for the current locale.
main();
function main(){
	mySetup();
	mySnippet()
	myTeardown()
}
function mySetup(){
	//<fragment>
	//Fill in the name of the key string you want to translate.
	var myString = app.translateKeyString("$ID/Convert to Note");
	alert(myString);
	//</fragment>
}
function mySnippet(){
}
function myTeardown(){
}

