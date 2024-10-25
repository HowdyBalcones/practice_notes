(function (){
	var doc = app.activeDocument;
	var selection = doc.selection;
	        
	var displayObjProperties = function(object) {
        	var propertiesArr = [];
                for (var key in object) {
                        if (object.hasOwnProperty(key)) {
                           propertiesArr.push(key + ": " + object[key]);
				propertiesArr.push(key.typename + " " + key.keys);
                           // alert(key + ": " + user[key]);
			} else if (key.typename == "object") {
				displayObjProperties(key);
			}
                }
                var sorted = propertiesArr.sort();
                alert(sorted.join("\n"))
        };

	function checkObjectKeys(object) {
		var properties = [];
		for (var i = 0; i < selection.length; ++i) {
			var item = selection[i];
			properties.push("Item " + (i + 1) + ":");
			for (var key in item) {
				// there are properties that aren't viewable, so we have to handle those. 
				try {
				if (item.hasOwnProperty(key)) {
					properties.push(key + " " + item[key]);
					// alert(key);
					
				} 
				} catch(e) {
					properties.push(" " + key + ": unaccessible");
				}					
			}
		}
		dialogAttempt(properties.join("\n"))
	}

	function showDialog(content) {
		var dlg = new Window("dialog", "Object Properties", undefined, { resizable: true });
		dlg.orientation = "column";
		dlg.alignChildren = ["fill", "fill"];

		var mainPanel = dlg.add("panel", undefined, "Panel Main");
		mainPanel.size = [400, 400];
		mainPanel.orientation = "column";
		mainPanel.alignChildren = ["fill", "fill"];

		var group = mainPanel.add("group");
		group.orientation = "row";
		group.alignChildren = ["fill", "fill"];



		var mainPanelScroll = mainPanel.add("scrollbar", undefined, 0, 0, 100);
		mainPanelScroll.size = [20, 1200];
		mainPanelScroll.location = [100, 10];

		var text = group.add("statictext", undefined, content, { multiline: true });
		text.characters = 80;
		text.maximumSize.height = 3000;
		
		mainPanelScroll.onChanging = function() {
			text.location = [10, -mainPanelScroll.value]
		}

		var closeButton = dlg.add("button", undefined, "Close");
		closeButton.onClick = function() {
			dlg.close();
		};
		dlg.show();
	}

	function dialogAttempt(content) {
		var g,p,w;
		var btnCancel, btnFolderInput, btnOk, txtInput;

		w = new Window("dialog", "Testing text output dialog");
		w.orientation = "column";

		p = w.add("panel");
		p.size = [400,400];
		p.orientation = "column";

		g = p.add("group");
		
		txtInput = g.add("statictext", undefined, content, {multiline: true});
		txtInput.size = [380,380]

		var scroll = w.add("scrollbar", undefined, 0, 0, 100);
		scroll.preferredSize = [20, 100];
		scroll.onChanging = function() {
			txtInput.location = [10, -p.value];
		}

		w.show();
	}
	

//	displayObjProperties(selection);
	if (selection.length > 0) {
	checkObjectKeys(selection);
	} else {
		alert("No Items Selected");
	}
})();
