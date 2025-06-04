// Generic Pages from XML script
(function() {
   var doc = app.activeDocument;
   function testing() {
      if (!doc) {
         throw new Error("No open document\n");
      } else {
         alert("working");
      }
   }

   function make_table() {
      var last_page = doc.spreads[-1];
      var component_page = doc.spreads[0];
      var all_components = component_page.allPageItems;
      var test_table = "<TARGET_TABLE_ADDON>";
      //var test_table = component_page.tables.itemByName("<TARGET_TABLE_ADDON>").isValid;
      //alert(all_components[0].isValid)
      for (var i = 0; i < all_components.length; ++i) {
         var component = all_components[i];
         if (component.name === test_table) {
            alert("yes" + i)
         } else {
            continue;
         }
      }


      // for spreads, we have to loop through items to find the object, or use a more specific collection
      // tables are nested inside text frame objects
      // alert(last_page.id + "\n" + component_page.id);
   }
   make_table();
   // testing();
})()
