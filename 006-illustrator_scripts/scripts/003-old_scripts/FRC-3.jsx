// TODO
// > pre-fill an indesign book template
//    + fill the book header with contract data, prompt the user for the info that a contract won't have
//    + create master pages from unique section data 
//    + pre-fill the sheet number abbreviations
//    + generally, lets get the template closer to a filable form. We need to understand the constraints and needs of that tool. 


(function() {
   var doc = app.activeDocument;
   var json_path = "~/Desktop/clean_contract_db_l2/json_data/";
   var test_file = "~/Desktop/clean_contract_db_l2/json_data/2003SWC01S--AUGUSTA FLATS.json";
   try {
      // #include "/Users/camdenbailey/Desktop/practice_notes/006-illustrator_scripts/scripts/FRC-obj.jsxinc";
   } catch(e) {
      console.log("Error including modules");
   }
  
   try {
      var json_file = new File(test_file);
       
      json_file.open("r");
      var json_string = json_file.read();
      json_file.close();
      // var data = JSON.parse(json_string);
      alert(json_string);
      var test = parse_JSON(json_string);
      alert(test[0][0]);
      var test_format = parse_json_array(test);
      alert(test_format);
      var test_aoo_to_aoa = aoo_to_aoa(test);
      array_to_text_box(test_aoo_to_aoa);  
      // alert(test_aoo_to_aoa);
   } catch(e) {
      alert("Error writing files" + e);
   }

   function parse_JSON(json_string) {
      const within_brackets_regex = /^\[]$/
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
