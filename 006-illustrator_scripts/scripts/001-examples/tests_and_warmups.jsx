
   
   function auth_xml_db() {
      var files = File.openDialog("Select files for authorization: ", undefined, true);
      return files; 
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

  
   function test_import_xml() {
     // var file_path = 'practice_notes/010-npm_node/02-results/000-xml_lib/2001E01S Encore Lower Broadway Signage.xml';
     // var desktop_folder = Folder.desktop;
     // var testing_file1 = new File(desktop_folder.fsName + '/' + file_path);
      var testing_file2 = auth_xml_db();
      alert(testing_file2[0].exists);
      var root_element = doc.importXML(testing_file2[0]);

   }