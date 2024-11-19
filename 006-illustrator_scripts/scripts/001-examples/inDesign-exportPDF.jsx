// this makes something called an Immediately Invoked Function Expression (IIFE) that runs as soon as it's defined
// IIFE has several advantages, such as not polluting global scope, async functions in older browsers, and can function as a Class

(function() {
	// Declaring variables
	var pdfPresetNames;
	var title = 'Adobe Indesign Tutorial 1'
	var g;
	var p;
	var w;
	
	var btnCancel;
	var btnFolderInput;
	var btnOk;
	var txtFolderInput;
	var listPdfPresets

	// Load application PDF presets
	pdfPresetNames = app.pdfExportPresets.everyItem().name; // store each pdf preset name 
	
	// create user interface
	w = new Window("dialog", title); //create a dialog window with title variable as name
	p = w.add("panel"); // add a panel to that window
	g = p.add("group"); // add a group to the panel
	btnFolderInput = g.add("button", undefined, "Folder..."); // Add a button to the group
	txtFolderInput = g.add("statictext", undefined, "", { // add a static text field
		truncate: "middle"
	});
	txtFolderInput.preferredSize = [200, -1]; // Setting preferred size 
	p = w.add("panel", undefined, "Options");
	g = p.add("group");
	g.add("statictext", undefined, "PDF preset:");
	listPdfPresets = g.add("dropdownlist", undefined, pdfPresetNames);
	// groups once defined can be written again using the same variable
	g = w.add("group"); // Add another group to the window
	g.alignChildren = "center"; // Center align the buttons 
	btnOk = g.add("button", undefined, "OK");
	btnCancel = g.add("button", undefined, "Cancel");

	// UI Event Handlers
	btnFolderInput.onClick = function() {
		var f = Folder.selectDialog(); // calls method on Folder object, opens files
		if (f) {
			txtFolderInput.text = f.fullName;
		}
	};
	btnOk.onClick = function() {
		w.close(1);
	};

	btnCancel.onClick = function() {
		w.close(0);
	};

	// w.show();
	// instead of calling show on the window we've made, we test the returned value of the buttons
	if(w.show() == 1) {
		process();
	}

	function process() {
		alert('Done', title, true);
	}
})();
