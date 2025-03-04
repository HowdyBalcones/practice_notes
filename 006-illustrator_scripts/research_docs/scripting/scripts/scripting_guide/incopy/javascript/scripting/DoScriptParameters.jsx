//DoScriptParameters.jsx
//An InCopy JavaScript
//
//Shows how to send parameters to a script called using
//the doScript method.
main();
function main(){
	var myParameters = ["Hello from DoScript", "Your message here."];
	mySetup();
	mySnippet(myParameters);
	myTeardown();
}
function mySetup(){
}
function mySnippet(myParameters){
	//For JavaScript, the parameters passed to do script must
	//be the same as the parameters passed to the function
	//containing the doScript call.
	//<fragment>
	var myJavaScript = "alert(\"First argument: \" + arguments[0] + \"\\rSecond argument: \" + arguments[1]);";
	app.doScript(myJavaScript, ScriptLanguage.javascript, myParameters);
	if(File.fs == "Windows"){
		var myVBScript = "msgbox arguments(1), vbOKOnly, \"First argument: \" & arguments(0)";
		app.doScript(myVBScript, ScriptLanguage.visualBasic, myParameters);
	}
	else{
		var myAppleScript = "tell application \"Adobe InCopy CC 2018\"\rdisplay dialog(\"First argument: \" & item 1 of arguments & return & \"Second argument: \" & item 2 of arguments)\rend tell";
		app.doScript(myAppleScript, ScriptLanguage.applescriptLanguage, myParameters);
	}
}
function myTeardown(){
}
