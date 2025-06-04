// Generic Pages from XML script
(function() {
   try {
   var doc = app.activeDocument;
   #include "./FRC-pg_template.jsxinc"
   } catch (init_error) {
      throw new Error("Some wrong in make_tables initialization\n" + init_error);
   }
   var component_page = doc.spreads[0];
   var last_page = doc.spreads[-1];
   var map = create_template_map();
   var test_template = map.lces
   var test_table = [
      ["A", "A, string", "X7", "something client to something"],
      ["A", "A string", "X7", "something client to something"],
      ["A", "A string", "X7", "something client to something"],
      ["A", "A string", "X7", "something client to something"]
   ];

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

   function place_table(target_spread, table) {
      // test: var table = get_table(component_page, test_template);
      alert(table.id)
      if (!table) {
         throw new Error("No table in place_table\n");
      }

      var new_table = table.duplicate(target_spread);
      alert(new_table.id);
      return new_table;
   }

   function get_data(data) {
      return data;
   }

   function fill_table(target_table, data) {
      var input_tbl = target_table.tables[0];

      if (!target_table) {
         throw new Error("Table is invalid in fill_table\n");
      }

      for (var i = 0; i < data.length; ++i) {
         var row = data[i];
         var tbl_row = input_tbl.rows[i+1];

         for (var j = 0; j < row.length; ++j) {
            var data_cell = row[j];
            var tbl_cell = tbl_row.cells[j];
            tbl_cell.contents = data_cell;
         }
      }   
      return target_table;
   }

   function main() {
      // var table_template = get_table(component_page, test_template);
      // var new_table = place_table(last_page, table_template);
      var tbl = doc.selection[0];
      fill_table(tbl, test_table);
   }
   // place_table(last_page)
   // main();

   //get_table(component_page, test_template);
   // testing();
})()
