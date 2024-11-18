(function() {

    // Script Variables
    // var doc = app.activeDocument;
    var title = "ui-basic-2_5";
    var abort;

    // Reusable UI Variables
    var w, p, g; // window, panel, group.
    
    // Permanent UI variables
    var btnCancel;
    var btnOk;

    var btnFolderInput;
    var btnFolderOutput;

    var txtFolderInput;
    var txtFolderOutput;

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

    btnFolderOutput = g.add("button", undefined, "Folder...");
    txtFolderOutput = g.add("statictext", undefined, "", {
        truncate: "middle"
    });
    txtFolderOutput.preferredSize = [200, -1];
    
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
    btnFolderOutput.onClick = function() {
        var f = Folder.selectDialog();
        if (f) {
            // we want to show the folder path in next to the folder button
            txtFolderOutput.text = f.fullName;
        }
    };
    btnOk.onClick = function() {
        // close the parent container "window" and return value 1
        if (!txtFolderInput.text) {
        alert("Select input folder to process", " ", false);
        return;
       }
        if (!txtFolderOutput.text) {
        alert("Select output folder to process", " ", false);
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
        // Ignore messages when openeing docs
        app.displayDialogs = DialogModes.NO;
        progress("Processing...");
        try {
        files = new Folder(txtFolderInput.text).getFiles(); // get files from list in txtFolderInput, array
        if (!files.length) {
            abort = "No files found in the selected folder";
            return;
        }

        progress.set(files.length);
        
        for (var i = 0; i < files.length; ++i) { // loop over the array of files
            processFile(files[i]);
        }
        } finally {
          progress.close();
        }
    };

    function processFile(file) {
        var doc;
        var fileJpg;
        var layerText;
        var textItem;
        var saveOptions;
        var scale;
        var scaleH;
        var scaleW;

        doc = app.open(file); // open each file in selected folder
            try {
                progress.message(File.decode(doc.name));
                // add text to a new layer on each image
                layerText = doc.artLayers.add();
                layerText.kind = LayerKind.TEXT;
                layerText.name = "text";
                textItem = layerText.textItem;
                textItem.contents = "YA MOMS A HOE"
                textItem.font = "Arial"
                textItem.size = 12;
                textItem.justification = Justification.LEFT;
                textItem.color.rgb.hexValue = "000000";
                textItem.position = [100, 100];

                // change image size
                scaleH = 800/doc.height;
                scaleW = 1200/doc.width;
                scale = Math.min(scaleH, scaleW);
                if (scale < 1) {
                doc.resizeImage(doc.width * scale, doc.height * scale, null, ResampleMethod.BICUBICSHARPER)
                }

                fileJpg = new File(txtFolderOutput.text + "/" + doc.name.replace(/\.[^\.]*$/, "") + ".jpg");
                saveOptions = new JPEGSaveOptions();
                saveOptions.embedColorProfile = true;
                saveOptions.formatOptions = FormatOptions.STANDARDBASELINE;
                saveOptions.quality = 1;
                doc.saveAs(fileJpg, saveOptions);
                progress.increment();
            } finally {
                doc.close(SaveOptions.DONOTSAVECHANGES);
             }
    }

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