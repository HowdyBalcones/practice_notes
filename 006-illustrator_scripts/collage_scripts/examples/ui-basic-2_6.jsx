(function() {

    // Script Variables
    // var doc = app.activeDocument;
    var title = "ui-basic-2_6";
    var filePdf;
    var abort;


    // Reusable UI Variables
    var w, p, g; // window, panel, group.
    
    // Permanent UI variables
    var btnCancel;
    var btnOk;

    var btnFolderInput;
    var btnFileOutput;

    var txtFolderInput;
    var txtFileOutput;

    // SETUP 

    // CREATE USER INTERFACE

try {
    w = new Window("dialog", title);
    // w.preferredSize = [200, 100];
    w.alignChildren = "fill";

    // add folder input button
    p = w.add("panel", undefined, "Input");
    g = p.add("group");

    btnFolderInput = g.add("button", undefined, "Folder...");
    txtFolderInput = g.add("statictext", undefined, "", {
        truncate: "middle"
    });
    txtFolderInput.preferredSize = [200, -1];


    
    // add folder output button
    p = w.add("panel", undefined, "Output");
    g = p.add("group");
    g.alignment = "left";

    btnFileOutput = g.add("button", undefined, "File...");
    txtFileOutput = g.add("statictext", undefined, "", {
        truncate: "middle"
    });
    txtFileOutput.preferredSize = [200, -1];
    
    // making dropdown list
    

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
    btnFileOutput.onClick = function() {
        var f = File.saveDialog();
        if (f) {
            // we want to show the folder path in next to the folder button
            txtFileOutput.text = f.fullName;
            filePdf = f;
        }
    };
    btnOk.onClick = function() {
        // close the parent container "window" and return value 1
        if (!txtFolderInput.text) {
        alert("Select folder to process", " ", false);
        return;
       }
        if (!txtFileOutput.text) {
        alert("Select output file to process", " ", false);
        return;
       }
        w.close(1);
    };
    
    btnCancel.onClick = function() {
        w.close(0);
    };

    if (w.show() === 1) {
        try {
        process();
        alert(abort || "Export Complete", title, false)
        } catch(e) {
            alert("Unexpected error. \n " + e.line + ": " + e.message, title, true)
        }
    };

    function process() {
        // do something here
        // alert("Done", title, false);
        var files;
        var presentationOptions = new PresentationOptions();
        var pdfSaveOptions = new PDFSaveOptions();

        // Ignore messages when openeing docs
        app.displayDialogs = DialogModes.NO;
        progress("Processing...");
        try {
        files = new Folder(txtFolderInput.text).getFiles(function(f) {
            if (f.hidden || f instanceof Folder) {
                return false;
            }
            return true;
        }); // get files from list in txtFolderInput, array
        if (!files.length) {
            abort = "No files found in the selected folder";
            return;
        }       
        presentationOptions.presentation = false;
        pdfSaveOptions.presetFile = "smallish_jpg-1";
        presentationOptions.PDFFileOptions = pdfSaveOptions;
        app.makePDFPresentation(files, filePdf, presentationOptions);
        } finally {
          progress.close();
        }
    };

    function progress(message) {
        var b; // bar, text, window
        var t;
        var w;
        w = new Window("palette", "Progress");
        // w.preferredSize = [450, 250];
        t = w.add("statictext", undefined, message);
        t.preferredSize = [450, -1]; // width, height
        b = w.add("progressbar");
        b.preferredSize = [450, 25];

        progress.close = function() {
            w.close();
        };
        progress.increment = function() {
            b.value++;
            app.refresh();
        };
        progress.message = function(message) {
            t.text = message;
            app.refresh();
        };
        progress.set = function(steps) {
            b.value = 0;
            b.minvalue = 0;
            b.maxvalue = steps;
        };
        w.show();
        app.refresh();
    }
    } catch(e) {
    alert(e, undefined, true);
}
})();