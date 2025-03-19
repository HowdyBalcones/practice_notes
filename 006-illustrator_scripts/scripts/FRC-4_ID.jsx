(function() {
   var doc = app.activeDocument;
   if (!doc) {
      throw new Error("No open document to target\n");
   }

   function auth_xml_db() {
      var files = File.openDialog("Select files for authorization: ", undefined, true);
      return files; 
   }

   function read_file_properties(file_obj) {
      var str = 'Object Properties:';
      for (var key in file_obj) {
         str += 'key: ' + key + ' : ' + 'property: ' + file_obj[key];
      }      
      alert(str);
   }

   // for most cases, this will show us object internals
   var displayObjProperties = function(object) {
      var propertiesArr = [];
      for (var key in object) {
         if (object.hasOwnProperty(key)) {
            propertiesArr.push(key + ": " + object[key]);
         }
      }
      var sorted = propertiesArr.sort();
      alert(sorted.join("\n"))
   }

   // this will test for various properties of a file. 
   function test_file(obj) {
      try {
        if (!obj.exists) {
           throw new Error("File does not exist: " + test_file.fsName);
        }
        // displayObjProperties(doc.pages[0]);
        alert("File Path: " + obj.fsName);
        alert("File exists: " + obj.exists);
        alert("Is readable: " + obj.length);
        alert("Full Path: " + obj.absoluteURI);
        alert("Type: " + typeof obj);
        alert("Permissions: " + obj.openPermission);
        alert("Readable: " + obj.readonly);
        alert("Encoding: " + obj.encoding);
        for (var key in obj) {
           alert("Property and Key: " + obj[key]);
        }

        alert("property test: " + obj.hasOwnProperty("readonly"))
        alert(Object.getOwnPropertyNames(obj));

      } catch(e) {
           throw new Error("Error testing object: " + e);
      }
   }

   function create_master_page() {
      alert(doc.masterSpreads[0].name);
      var name_test = 'TESTING';
      var spreads_len = doc.masterSpreads.length;
      var main_spread = doc.masterSpreads[0];
      var sub_main_spread = doc.masterSpreads.itemByName("A-SUB-MAIN");
      sub_main_spread.duplicate();
      var duplicated_sub_spread = doc.masterSpreads[spreads_len];
      alert(duplicated_sub_spread.name)
      duplicated_sub_spread.baseName = name_test;
      // var spread_2 = sub_main_spread.duplicate();
      // alert(sub_main_spread.name);
      alert("Spread length: " + spreads_len);
      // alert(spread_2.name);
   }

   function set_main_spread() {
      // access the xml tree 
      var root_elements = doc.xmlElements[0];
      var metadata_elements = root_elements.xmlElements[0].xmlElements;
      var contract_elements = root_elements.xmlElements[1].xmlElements;
      var unique_sign_elements = root_elements.xmlElements[2].xmlElements;
      
      // access metadata element values
      var xml_quote_num = metadata_elements.itemByName('quote_num');
      var xml_contract_file = metadata_elements.itemByName('contract_file');
      var xml_client_name = metadata_elements.itemByName('client_name');
      var xml_project_name = metadata_elements.itemByName('project_name');
      var xml_project_address = metadata_elements.itemByName('project_address');
      
      // access the master spreads
      var main_spread = doc.masterSpreads.itemByName("A-MAIN");
      var sub_spread = doc.masterSpreads.itemByName("A-SUB-MAIN");

      // access pageItems in the main_spread
      var quote_number = main_spread.pageItems.itemByName("<QUOTE_NUMBER>");
      var project_name = main_spread.pageItems.itemByName("<PROJECT_NAME>");
      var client_name = main_spread.pageItems.itemByName("<CLIENT_NAME>");
      var project_address = main_spread.pageItems.itemByName("<PROJECT_ADDRESS>");

      // access pageItems in the sub_spread
      var find_test = sub_spread.pageItems.itemByName("<SHEET_DATE>");
      var sheet_title = sub_spread.pageItems.itemByName("<TARGET_SHEET_TITLE>")
      var designer_initials = sub_spread.pageItems.itemByName("<DESIGNER_INITIALS>");
      var sheet_page_label = sub_spread.pageItems.itemByName("<SHEET_PG_LABEL>");

      // set main_spread variables
      xml_quote_num.placeXML(quote_number);
      xml_client_name.placeXML(client_name);
      xml_project_name.placeXML(project_name);
      xml_project_address.placeXML(project_address);
      alert("Set main spread information");
      
    // set sub_spread variables
    // alert(quote_number.name + project_name.name + client_name.name + project_address.name);
    // alert(designer_initials.name);
    // for (var i = 0; i < metadata_elements.length; ++i) {
    //      str += metadata_elements[i].contents + '\n';
    // }
    //  var target_text = sub_spread.pageItems[0];
    //  alert(find_test.constructor.name);
    //  if (find_test && find_test.isValid) {
    //     alert("FOUND");
    //     alert(find_test.name);
    //     find_test.name = "<RENAMED_TEST>";
    //  } else {
    //     alert("NOT FOUND");
    //  }

   }

   function set_sub_spreads() {
      // this will duplicate the sub_spread template, rename the spread, fill the variable data, and continue for each section.  
      try {
         try {
            var root_elements = doc.xmlElements[0];
            var contract_elements = root_elements.xmlElements[1].xmlElements;
         } catch(xml_error) {
            // alert("Error reading xml" + xml_error);
            throw new Error("Error reading xml root\n" + xml_error);
         }

      alert(contract_elements.length);
      var sub_spread = doc.masterSpreads.itemByName("A-SUB-MAIN");

         for (var i = 0; i < contract_elements.length; ++i) {
            sub_spread.duplicate();
            var len = doc.masterSpreads.length;
            var newest_spread = doc.masterSpreads[len-1];
            // alert(newest_spread.name);
            var quote_number = newest_spread.pageItems.itemByName("<SHEET_DATE>");
            var project_name = newest_spread.pageItems.itemByName("<TARGET_SHEET_TITLE>");
            var client_name = newest_spread.pageItems.itemByName("<DESIGNER_INITIALS>");
            var project_address = newest_spread.pageItems.itemByName("<SHEET_PG_LABELS>");             
            alert(client_name.name);
         }
      } catch(sub_spread_error) {
         alert("Error in sub_spread function" + sub_spread_error.message);
         throw new Error("Error in sub_spread\n" + sub_spread_error);
      }
   }  

   function fill_master_spreads_xml() {

   }

   function prompt_user_variables() {

   }

   function test_import_xml() {
     // var file_path = 'practice_notes/010-npm_node/02-results/000-xml_lib/2001E01S Encore Lower Broadway Signage.xml';
     // var desktop_folder = Folder.desktop;
     // var testing_file1 = new File(desktop_folder.fsName + '/' + file_path);
      var testing_file2 = auth_xml_db();
      alert(testing_file2[0].exists);
      var root_element = doc.importXML(testing_file2[0]);

   }

   try {
      // set_main_spread();
      set_sub_spreads();
      // test_xml_elements();
      // create_master_page();
      // test_import_xml();
   } catch(main_err) {
      throw new Error('Error with main script\n' + main_err);
   }

  

   // alert("testing")

}())
