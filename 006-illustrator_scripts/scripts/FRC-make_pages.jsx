// Generic Pages from XML script
(function() {
   var doc = app.activeDocument;
   #include "./FRC-pg_template.jsxinc"

   var component_page = doc.spreads[0];
   var last_page = doc.spreads[-1];
   var map = create_template_map();
   var test_template = map.lces
   function testing() {
      if (!doc) {
         throw new Error("No open document\n");
      } else {
         alert("working");
      }
   }

   function get_table(target_spread, template_obj) {
      var all_components = target_spread.allPageItems;
      var target_table = template_obj.table_type;

      if (!all_components) {
         throw new Error("Invalid spread in get_table\n");
      }

      for (var i = 0; i < all_components.length; ++i) {
         var component = all_components[i];
         if (component.name === target_table) {
            //alert("yah")
            return component;
         } else {
            continue;
         }
      }
   }

   // this works, pick
   function place_table(target_spread) {
      var table = get_table(component_page, test_template);
      alert(table.id)
      if (!table) {
         throw new Error("No table in place_table\n");
      }

      table.duplicate(target_spread);
   }

   function fill_table(target_table) {
      // take xml and fill the given table
   }
   place_table(last_page)

   //get_table(component_page, test_template);
   // testing();
})()
