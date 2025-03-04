//DoScriptReturnValues.jsx
//An InCopy JavaScript
//
//Shows how to return values from a script called using
//the doScript method.
var myJavaScript = "[\"This is the first script argument value.\", \"This is the second script argument value.\"]";
var myArray = app.doScript(myJavaScript, ScriptLanguage.javascript);
alert("ScriptArgumentA: " + myArray[0] + "\rScriptArgumentB: " + myArray[1]);