(function(){
	var doc = app.activeDocument;
	var clipBoard = app.clipboardPreferences;
	var user = doc.cjkGridPreferences;
	
	var displayObjProperties = function(object) {
		var propertiesArr = [];
		for (var key in object) {
			if (object.hasOwnProperty(key)) {
				propertiesArr.push(key + ": " + object[key]);
				// alert(key + ": " + user[key]);
			}
		}
		var sorted = propertiesArr.sort();
		alert(sorted.join("\n"))
	}
	displayObjProperties(clipBoard);
 })()
