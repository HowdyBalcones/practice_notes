var doc = app.activeDocument;
var prodLog = new File("/Applications/Adobe Illustrator 2024/Presets.localized/en_US/Scripts/prodLog.txt");

// this could be a method to pass an illustrator script parameters from bash
// works by storing path to the active directory in a temp file, then this jsx
// script reads and initializes that path as a variable usable in the script
function readParameterFile () {
	var parameterFile = new File("~/tempFiles/illustratorParams.txt");
	if (parameterFile.open("r"))
		{
			var parameterFileContents = parameterFile.read();
			parameterFile.close();
			return parameterFileContents;
			// this gets the path to the working directory into a variable for the script
		} else {
			alert("Failed to open the parameter file.");
			return null;
		}
}

