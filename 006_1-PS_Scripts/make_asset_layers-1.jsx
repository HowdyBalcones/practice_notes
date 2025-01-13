// This script is intended for use with Adobe Photoshop
// IIFE
(function() {
   if (!app.documents.length) {
      alert("Please open a document with paths before running this script.");
      exit();
   }
   var doc = app.activeDocument;
   
   
   function paste_paths(targetDoc, pathName) {
         // takes a path name, creates selection from path, copies selection, makes a new layer,
         // names layer after selection, paste selection into new layer
      var startingDialogMode = app.displayDialogs;
      app.displayDialogs = DialogModes.ERROR;
      try {
        targetDoc.activePath = pathName;
        targetDoc.pathItems.getByName(pathName).makeSelection();
        targetDoc.activePath = null;
        targetDoc.selection.copy();
         
         var newLayer = targetDoc.artLayers.add();
         newLayer.name = pathName;
         targetDoc.paste();
         targetDoc.selection.deselect();
         var len = targetDoc.artLayers.length;
         targetDoc.activeLayer = targetDoc.artLayers[len-1];
      } catch(e) {
         alert(e);
         app.displayDialogs = startingDialogMode;
      }
      app.displayDialogs = startingDialogMode;
   }
   
   function create_asset_layers(targetDoc) {
      app.activeDocument = targetDoc;
      for (var i = 0; i < targetDoc.pathItems.length; ++i) {
         var currentPath = targetDoc.pathItems[i];
         paste_paths(targetDoc, currentPath.name);
      }
      alert("Done pasting layers");
   }

   function test_paths() {
      for (var i = 0; i < doc.pathItems.length; ++i) {
         var currentPath = doc.pathItems[i];
         alert(currentPath);
      }
   }

   function export_layer_tif(layer, export_path) {
      if (export_path) {
         var exportFolder = export_path;
      } else {
         var exportFolder = Folder.selectDialog("Select folder for Tiff exports");
      }
      if (!exportFolder) {
         alert("Export cancelled");
         exit();
      }
      // consider creating some other scheme for naming files here. 
      var fileName = layer.name.replace(/[\/\\:\*\?\"\<>\|]/g, "");
      var filePath = exportFolder + "/" + fileName + ".tif"; 

      var tempDoc = doc.duplicate();
         for (var i = tempDoc.artLayers.length - 1; i >= 0; --i) {
            if (tempDoc.artLayers[i].name !== layer.name) {
               tempDoc.artLayers[i].remove();
            }
         }
      var options = new TiffSaveOptions();
      options.alphaChannels = true;
      options.transparency = true;
      tempDoc.saveAs(new File(filePath), options, true, Extension.LOWERCASE);
      tempDoc.close(SaveOptions.DONOTSAVECHANGES);
   }

   function export_layer_png(sourceDoc) {
      // set the active doc to a variable, initialize things needed later, make png options object, prompt user for export
      // destination, if the export is cancelled handle the error
     try {
      if (!sourceDoc) {
         var sourceDoc = app.documents[0];
      }
      var height, width, resolution, name; 
      var png_options = new PNGSaveOptions();
      png_options.transparency = true;
      resolution = 72;
      
      var exportFolder = Folder.selectDialog("Select folder for Tiff exports");
      if (!exportFolder) {
         alert("Export Cancelled");
         return;
      }
      
      for (var i = 0; i < sourceDoc.artLayers.length; ++i) {
         // layer item, random number for name, bounds object of layer item, height and width calculations, naming for layer and file
         var layer = sourceDoc.artLayers[i];
         var r = Math.round(Math.random()*1000);
         var bounds = layer.bounds;
         width = bounds[2].as("px") - bounds[0].as("px");
         height = bounds[3].as("px") - bounds[1].as("px");
         name = layer.name.replace(/[\/\\:\*\?\"\<>\|]/g, "") + (r+i).toString();
         var fileName = exportFolder + "/" + name + ".png";        
         
         // if the layer is locked skip loop body and move to next layer item
         if (layer.pixelsLocked) {
            continue;
         }
         // set only the current layer item to be visible, otherwise it copies the layer stack despite explicit reference to a layer
         for (var j = 0; j < sourceDoc.artLayers.length; ++j) {
            sourceDoc.artLayers[j].visible = (j === i);
         }
         // here we make a temporary document using the above variables, it will be the target document for copied data
         var tempDoc = app.documents.add(
            width,
            height,
            resolution,
            name,
            NewDocumentMode.RGB,
            DocumentFill.TRANSPARENT
         );
         // to duplicate a layer, the source document must be the "frontmost", or active, document. 
         app.activeDocument = sourceDoc;
         layer.duplicate(tempDoc);   
         
         app.activeDocument = tempDoc;
         center_layer_to_canvas(tempDoc);
        
         // save and close the temp doc, repeat loop
         tempDoc.saveAs(new File(fileName), png_options, true, Extension.LOWERCASE);
         tempDoc.close(SaveOptions.DONOTSAVECHANGES);
         for (var j = 0; j < sourceDoc.artLayers.length; ++j) {
            var layer = sourceDoc.artLayers[j];
            layer.visible = true;
         }
      }
     } catch(e) {
        alert(e);
     }
      alert("exported all layers.");
   }

   function center_layer_to_canvas(targetDoc) {
      // this works on the topmost layer
      var targetDocLayer = targetDoc.artLayers[0];
      var bounds = targetDocLayer.bounds;
      var canvasCenterX = targetDoc.width / 2;
      var canvasCenterY = targetDoc.height / 2;
      var layerCenterX = (bounds[0].as("px") + bounds[2].as("px")) / 2;
      var layerCenterY = (bounds[1].as("px") + bounds[3].as("px")) / 2; 
      var offsetX = canvasCenterX - layerCenterX;
      var offsetY = canvasCenterY - layerCenterY;
      targetDocLayer.translate(offsetX, offsetY);
   }

   function process_each_doc() {
      for (var i = 0; i < app.documents.length; ++i) {
         var targetDoc = app.documents[i];
         create_asset_layers(targetDoc);       
         export_layer_png(targetDoc);
      }
   } 

   function test_with_alert() {
      alert("testing");
   }
   
   // this is how to make a new fresh doc
   function test_newDoc() {
      var test_doc = app.documents.add();
      alert("new doc made");
   }

   function test_get_by_name() {
      if (app.documents.getByName("Untitled-1")) {
         alert("got the document");
      };
   }

   function test_layer_duplication() {
      var sourceDoc = app.documents[0];
      var targetDoc = app.documents[1];
      var layer = sourceDoc.artLayers[1];
      layer.duplicate(targetDoc);
   }

   function test_doc_order() {
      for (var i = 0; i < app.documents.length; ++i) {
         var docc = app.documents[i];
         alert(docc.name + "\n" + "Number: " + i);
      }
   }

   function test_setting_active_doc() {
      var doc1 = app.documents[0];
      app.activeDocument = doc1;
   }

// test_doc_order();
// test_get_by_name();
process_each_doc();
//export_layer_tif2();
// test_setting_active_doc(); 
//test_layer_duplication();
//   test_with_alert();
//  create_asset_layers();
// export_layer_tif2();
// test_paths();
// test_newDoc();
})();


