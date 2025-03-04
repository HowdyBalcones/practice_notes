// TODO
// > pre-fill an indesign book template
//    + fill the book header with contract data, prompt the user for the info that a contract won't have
//    + create master pages from unique section data 
//    + pre-fill the sheet number abbreviations
//    + generally, lets get the template closer to a filable form. We need to understand the constraints and needs of that tool. 
// NOTES
// > JSON is not an extendscript method, would have to systemCall() an external script for that
// > seems like ID handles file paths very differently than illustrator. 

(function() {
   var doc = app.activeDocument;
   // var test_file_path = Folder.desktop + "/testing_text.txt";
   // var test_file_path = "/Volumes/Macintosh HD/Users/camdenbailey/Desktop/testing_text.txt";
   var test_file_path = "/Volumes/Macintosh HD/Users/camdenbailey/Desktop/testing_text2.txt";
   var test_file = new File(test_file_path);
   try {
      // #include "/Users/camdenbailey/Desktop/practice_notes/006-illustrator_scripts/scripts/FRC-obj.jsxinc";
   } catch(e) {
      console.log("Error including modules");
   }
  
   try {
      if (!test_file.exists) {
         throw new Error("File does not exist: " + test_file.fsName);
      }
      alert("File Path: " + test_file.fsName);
      alert("File exists: " + test_file.exists);
      alert("Is readable: " + test_file.length);
      alert("Full Path: " + test_file.absoluteURI);
      alert("Type: " + typeof test_file);
      alert("Permissions: " + test_file.openPermission);
      alert("Readable: " + test_file.readonly);
      test_file.readonly = true;
      alert("Readable Edited: " + test_file.readonly);

      test_file.encoding = "UTF-8";
      alert(test_file.encoding);
      for (var key in test_file) {
         alert("Property and Key: " + test_file[key]);
      }

      alert("property test: " + test_file.hasOwnProperty("readonly"))
      alert(Object.getOwnPropertyNames(test_file));

      alert(prop_names);
      if(test_file.open("r")) {
         alert("fak");
      } else {
         test_file = File.openDialog("Pick:");
         alert(test_file.fsName);

         // alert("Problem reading file:" + test_file.error)
         // alert("System Error: " + File.systemErrorMessage);
      }
  //   if (!test_file.exists) {
  //      throw new Error('File does not exist: ' + test_file.fsName);
  //      alert(test_file.absoluteURI);
  //   } else {
  //      alert("test file exists");
  //      if (!test_file.open("r")) {
  //         alert("not opening the file")
  //         alert("File object: " + test_file);
  //         for (var key in test_file) {
  //            alert(key + ": " + test_file[key]);
  //         }
  //         alert("File size: " + test_file.length);
  //         alert("File encoding: " + test_file.encoding);
  //      }
  //   }
   } catch(e) {
      throw new Error("Error writing files" + e + "\n" + e.message + "\n" + $.line);
   }

   function parse_JSON(json_string) {
      var within_brackets_regex = /^\[]$/
      // check for beginning and end brackets
      if (!/^[\[\{]/.test(json_string) || !/[\]\}]$/.test(json_string)) {
         throw new Error("Invalid JSON string");
      } 

      try {
         return eval('(' + json_string + ')');
      } catch(e) {
         throw new Error("Failed to parse JSON object: " + e.message);
      }
   }

   // this just makes a nicely formatted piece of text from a json array, proof of concept
   function parse_json_array(json_array) {
      var formatted_string = '';
      var temp_string = '';
      for (var i = 0; i < json_array.length; ++i) {
         var row = json_array[i];
         for (el in row) {
            temp_string += row[el] + " ";
         } 
       formatted_string += temp_string + "\n";
       temp_string = '';
      }
      return formatted_string;
   }

   function aoo_to_aoa(json_array) {
      var out_arr = [];
      var in_arr = [];
      for (var i = 0; i < json_array.length; ++i) {
         var row = json_array[i];
         for (el in row) {
            in_arr.push(row[el]);
         }
         out_arr.push(in_arr);
         in_arr = [];
      }
      return out_arr;
   }

   function array_to_text_box(aoa) {
      var new_contents = '';
      for (var i = 0; i < aoa.length; ++i) {
         var row = aoa[i];
         var line_item = row.join("\t");
         new_contents += line_item + "\n";
      }
      var new_text = doc.textFrames.add();
      new_text.name = "testing_script";
      new_text.contents = new_contents;
      new_text.position = [0,0];
   }
})();
