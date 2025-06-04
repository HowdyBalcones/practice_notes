      read_file_properties(authorized_xml_file[0]);
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
      #include "/Users/camdenbailey/Desktop/practice_notes/006-illustrator_scripts/scripts/001-examples/inDesign-identify.jsxinc";
   } catch(e) {
      console.log("Error including modules");
   }
  
   try {
      // test_obj(test_file);
      var json_db_files = auth_json_db();
      if (typeof json_db_files === "array") {
         alert("array")
      } else if (typeof json_db_files === "object") {
         alert("object")
      } else {
         alert(typeof json_db_files);
      }
      // alert(obj_count_keys(json_db_files));
      // var json_array = read_obj_keys(json_db_files);
      // alert(json_array[0]);
      // obj_show_keys(json_array[0]); // this will target row objects 
      // obj_show_keys(json_db_files);
      alert_selection(doc.selection);
   } catch(e) {
      throw new Error("Error writing files" + e + "\n" + e.message + "\n" + $.line);
   }

   function auth_json_db() {
      var file_arr = [];
      var files = File.openDialog("Select json files for authorization: ", undefined, true);
      return files; 
   }

   function obj_count_keys(obj) {
      var i = 0;
      for (var key in obj) {
         ++i;
      }
      return i;
   }

   function obj_show_keys(obj) {
      for (var key in obj) {
         alert("Property: " + key + "\n" + "Key: " + obj[key] + "\n");
      }
   } 

   function read_obj_keys(obj) {
      var json_array = [];
      for (var key in obj) {
         var path = obj[key];
         var file = new File(path);
         file.open("r");
         var json_string = file.read();
         file.close();
         json_string = parse_JSON(json_string);
         json_array.push(json_string);
      }
      return json_array;
   }

   function get_title_block_info(json_string) {

   }

   function alert_selection(sel) {
      var xml_tag = doc.xmlTags.itemByName("TestTag");
      if (!xml_tag.isValid) {
         xml_tag = doc.xmlTags.add({ name: "TestTag" });
      }

      if (sel.length > 0) {
         for (var i = 0; i < sel.length; ++i) {
            var item = sel[i];
            // alert(typeof sel[i]);
            // sel[i].constructor.label = "testing";
            // alert(sel[i].constructor.label);
            item.xmlElements.add(xml_tag);


         }
      }
   } 

   function test_obj(obj) {
      try {
        if (!test_file.exists) {
           throw new Error("File does not exist: " + test_file.fsName);
        }
        // displayObjProperties(doc.pages[0]);
        alert("File Path: " + test_file.fsName);
        alert("File exists: " + test_file.exists);
        alert("Is readable: " + test_file.length);
        alert("Full Path: " + test_file.absoluteURI);
        alert("Type: " + typeof test_file);
        alert("Permissions: " + test_file.openPermission);
        alert("Readable: " + test_file.readonly);
        alert("Encoding: " + test_file.encoding);
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
         }
      } catch(e) {
           throw new Error("Error testing object: " + e);
      }
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
