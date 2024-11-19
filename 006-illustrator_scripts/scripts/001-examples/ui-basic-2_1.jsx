(function() {
try {
    // Script Variables
    var doc = app.activeDocument;
    var title = "ui-basic-2_1";
    var pdfPresetNames;

    // Reusable UI Variables
    var w, p, g; // window, panel, group.
    
    // Permanent UI variables
    var listPdfPresets;
    var btnCancel;
    var btnOk;
    var btnFolderInput;
    var txtFolderInput;

    // SETUP 
    pdfPresetNames = app.pdfExportPresets.everyItem().name; // get the local pdf presets 
    pdfPresetNames.sort();
} catch(e) {
    alert(e + " location: initializers")
}
try {
    w = new Window("dialog", title);
    // w.preferredSize = [200, 100];
    p = w.add("panel");
    g = p.add("group");

    // add folder button
    btnFolderInput = g.add("button", undefined, "Howdy");
    txtFolderInput = g.add("statictext", undefined, "", {
        truncate: "middle"
    });
    txtFolderInput.preferredSize = [200, -1];
    
    // making dropdown list
    p = w.add("panel", undefined, "Options");
    w.alignChildren = "fill";
    g = p.add("group");
    g.alignment = "left";
    g.add("statictext", undefined, "PDF Preset:");
    listPdfPresets = g.add("dropdownlist", undefined, pdfPresetNames);

    // make ok and cancel buttons
    g = w.add("group");
    g.alignment = "center";

    btnOk = g.add("button", undefined, "OK");
    btnCancel = g.add("button", undefined, "Cancel");

    // EVENT HANDLERS
    // structure here -- you make a ui element, then use a UI method for that element, 
    // upon desired interaction you call a given anonymous function, where the desired
    // logic exists. That could be the entire contents of another script. 

    btnFolderInput.onClick = function() {
        var f = Folder.selectDialog();
        if (f) {
            // we want to show the folder path in next to the folder button
            txtFolderInput.text = f.fullName;
        }
    };

    function process() {
        // do something here
        // alert("Done", title, false);
        var doc;
        var filePdf;
        var files;
        var pdfPreset;
        // Get chosen preset, item, selection and text are builtins here, 
        pdfPreset = app.pdfExportPresets.item(listPdfPresets.selection.text);
        // Ignore messages when openeing docs
        app.scriptPreferences.userInteractionLevel = UserInteractionLevels.NEVER_INTERACT;
        // Set export to all pages
        app.pdfExportPreferences.pageRange = PageRange.ALL_PAGES;
        // Get inDesign files in folder from selected directory 
        files = new Folder(txtFolderInput.text).getFiles("*.indd"); // get files from list in txtFolderInput, array
        for (var i = 0; i < files.length; ++i) { // loop over the array of files
            doc = app.open(files[i]); // open each file in selected folder
            filePDF = new File(files[i].fullName.replace(/\.indd$/i, "") + ".pdf");
            doc.exportFile(ExportFormat.PDF_TYPE, filePDF, false, pdfPreset);
            doc.close(SaveOptions.NO);
        }
    };


    btnOk.onClick = function() {
        // close the parent container "window" and return value 1
        w.close(1);
    };
    
    btnCancel.onClick = function() {
        w.close(0);
    };

    if (w.show() === 1) {
        process();
    };

    } catch(e) {
    alert(e, undefined, true);
}
})();