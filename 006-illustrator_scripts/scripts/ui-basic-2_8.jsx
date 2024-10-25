(function() {

    // SCRIPT VARIABLES
    // var doc = app.activeDocument;
    var title = "ui-basic-2_8";
    // for mask replacement script
    var bounds, docMaster, mask, maskC, maskH, maskW;
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

    // check if your master doc is open
    if (!app.documents.length) {
        alert("Open the master document", title, false);
    }
    // make sure dialog boxes don't open
    app.displayDialogs = DialogModes.NO;
    app.preferences.rulerUnits = Units.PIXELS;
    docMaster = app.activeDocument;
    mask = docMaster.channels.getByName("mask");
    docMaster.selection.load(mask);
    bounds = docMaster.selection.bounds;
    maskW = bounds[2] - bounds[0]; // right side - left side = distance to right side
    maskH = bounds[3] - bounds[1]; // bottom side - top side = distance to bottom side
    maskC = [bounds[0] + (maskW/2), bounds[1] + (maskH/2)]; // center coordinates, array

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

    function maskLayer() {
        // Mask active layer using document selection.
        var desc1 = new ActionDescriptor();
        var ref1 = new ActionReference();
        desc1.putClass(charIDToTypeID("Nw  "), charIDToTypeID("Chnl"));
        ref1.putEnumerated(charIDToTypeID("Chnl"), charIDToTypeID("Chnl"), charIDToTypeID("Msk "));
        desc1.putReference(charIDToTypeID("At  "), ref1);
        desc1.putEnumerated(charIDToTypeID("Usng"), charIDToTypeID("UsrM"), charIDToTypeID("RvlS"));
        executeAction(charIDToTypeID("Mk  "), desc1, DialogModes.NO);
    }

    function process() {
        // do something here
        // alert("Done", title, false);
        var files;
        // Ignore messages when openeing docs
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
        // this is where the images are altered. 
        var doc;
        var baseName;
        // for the mask 
        var docWork, layer, layerC, layerH, layerW;
        var scale;
        var scaleH;
        var scaleW;
        docWork = docMaster.duplicate();

        doc = app.open(file); // open each file in selected folder
            try {
                progress.message(File.decode(doc.name));
                app.activeDocument = doc;
                doc.flatten();

                // change image size
                scaleH = maskH/doc.height;
                scaleW = maskW/doc.width;
                scale = Math.max(scaleH, scaleW);
                doc.resizeImage(doc.width * scale, doc.height * scale, null, ResampleMethod.BICUBICSHARPER)
                // Copy image to work document.
                layer = doc.layers[0].duplicate(docWork);
                app.activeDocument = docWork;
                docWork.activeLayer = layer;
                // Resize image to fit in master mask
                bounds = layer.bounds;
                layerW = bounds[2] - bounds[0];
                layerH = bounds[3] - bounds[1];
                layerC = [bounds[0] + (layerW / 2), bounds[1] + (layerH / 2)];
                layer.translate(maskC[0] - layerC[0, maskC[1] - layerC[1]]);
                docWork.selection.load(mask);
                maskLayer();

                // Save
                baseName = doc.name.replace(/\.[^\.]*$/, "") + "-framed";
                // saveJpg(docWork, baseName)
                // savePng(docWork, baseName);
                savePsd(docWork, baseName);
                progress.increment();
            } finally {
                doc.close(SaveOptions.DONOTSAVECHANGES);
                docWork.close(SaveOptions.DONOTSAVECHANGES);
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

    function saveJpg(document, name) {
        var file;
        var saveOptions;
        file = new File(txtFolderOutput.text + "/" + name + ".jpg");
        saveOptions = new JPEGSaveOptions();
        saveOptions.embedColorProfile = true;
        saveOptions.formatOptions = FormatOptions.STANDARDBASELINE;
        saveOptions.quality = 1;
        document.saveAs(file, saveOptions);
    }

    function savePng(document, name) {
        var file;
        var saveOptions;
        file = new File(txtFolderOutput.text + "/" + name + ".png");
        saveOptions = new PNGSaveOptions();
        saveOptions.compression = 5; 
        saveOptions.interlaced = false;
        document.saveAs(file, saveOptions);
    }
    function savePsd(document, name) {
        var file;
        var saveOptions;
        file = new File(txtFolderOutput.text + "/" + name + ".psd");
        saveOptions = new PhotoShopSaveOptions();
        saveOptions.alphaChannels = true;
        saveOptions.annotations = true;
        saveOptions.embedColorProfile = true;
        saveOptions.layers = true;
        saveOptions.spotColors = true;
        document.saveAs(file, saveOptions);
    }

    } catch(e) {
    alert(e, undefined, true);
}
})();