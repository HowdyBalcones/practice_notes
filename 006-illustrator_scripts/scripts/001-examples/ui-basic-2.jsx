
// run now function, iife
(function() {
    var g, p, w; // group, panel, window
    var btnFolderInput;
    var txtFolderInput;
    var btnOk;
    var btnCancel;
    // create user interface

    // check ScriptUI API for these objects
    w = new Window("dialog", "UI Basic");
    p = w.add("panel");    
    g = p.add("group");
    
    btnFolderInput = g.add("button", undefined, "Folder...");

    txtFolderInput = g.add("statictext", undefined, "", {truncate : "middle"});
    txtFolderInput.preferredSize = [200, 100]; // -1 means ignore dimension

    // make a new group, we can reuse the previous g variable
    g = w.add("group");
    g.alignChildren = "center";

    btnOk = g.add("button", undefined, "OK");

    btnCancel = g.add("button", undefined, "Cancel");

    // Event Handlers, so the UI does something 
    
    btnFolderInput.onClick = function() {
        // call folder object
        var f = Folder.selectDialog();
        if (f) {
            txtFolderInput.text = f.fullName;
        }
    }
 
     function process() {
        alert("Ok was clicked")
    }

    btnOk.onClick = function() {
        w.close(1);
    }

    btnCancel.onClick = function() {
        w.close(0);
    }
    if (w.show() === 1) {
        // here you would call a function based on the return values 
        process();
    }
    // need this before ui will appear
    // this returns the values passed to the btnOk and btnCancel onclick functions
    // so we can test the show() method of the window to apply effects


})();