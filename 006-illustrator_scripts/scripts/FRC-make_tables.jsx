// Generic Pages from XML script
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

function get_generic_table(target_spread, target_object) {
   var all_components = target_spread.allPageItems;
   for (var i = 0; i < all_components.length; ++i) {
      var component = all_components[i];
      if (component.name === target_object) {
         return component;
      } else {
         continue;
      }
   }
}

function place_table(target_spread, table) {
   if (!table) {
      throw new Error("No table in place_table\n");
   }
   var new_table = table.duplicate(target_spread);
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

function fill_table_xml(target_table, section) {
   try {
      var job_info = doc.xmlElements[0];
      if (!job_info) {
         throw new Error("No job_info");
      }

      var input_table = target_table.tables[0];
      var section_name = '';
      if (input_table.rows.length < section.length) {
         var diff = section.length - input_table.rows.length;
         for (var i = 0; i < diff; ++i) {
            input_table.rows.add();
         }
      } else if (input_table.rows.length > section.length) {
         var len = section.length;
         for (var i = input_table.rows.length - 1; i >= len; --i) {
            input_table.rows[i].remove();
         }
      }
      for (var i = 0; i < section.length; ++i) {
         if (section[i].markupTag.name === "section_name") {
            section_name = section[i].contents;
            continue;
         }
         var tbl_row = input_table.rows[i];
         var col1 = tbl_row.cells[0];
         var col2 = tbl_row.cells[1];
         var col3 = tbl_row.cells[2];
         var sign = section[i].xmlElements;
         var key = sign[0].contents;
         var desc = sign[1].contents;
         var count = sign[2].contents;
         col1.contents = key;
         col2.contents = count;
         col3.contents = desc;
      }
      target_table.fit(FitOptions.FRAME_TO_CONTENT);
   } catch (table_xml_error) {
      throw new Error("Problem with fill_table_xml " + table_xml_error.line + " " + table_xml_error + "\n");
   }
}

function fill_description_table(target_table, section) {
   try {
      var input_table = target_table.tables[0];
      var section_name = '';
 
      if (input_table.rows.length < section.length) {
         var diff = section.length - input_table.rows.length;
         for (var i = 0; i < diff; ++i) {
            input_table.rows.add();
         }
      } else if (input_table.rows.length > section.length) {
         var len = section.length;
         for (var i = input_table.rows.length - 1; i >= len; --i) {
            input_table.rows[i].remove();
         }
      }     
      for (var i = 0; i < section.length; ++i) {
         if (section[i].markupTag.name === "section_name") {
            section_name = section[i].contents;
            continue;
         }

         var tbl_row = input_table.rows[i];
         var col1 = tbl_row.cells[1];
         var col2 = tbl_row.cells[2];
         var col3 = tbl_row.cells[3];
         var sign = section[i].xmlElements;
         var key = sign[0].contents;
         var desc = sign[1].contents;
         var count = sign[2].contents;
         col1.contents = key;
         col2.contents = desc;
         col3.contents = "X " + count;
         //alert(desc + " " + key + " " + count + "\n")
      }
      input_table.rows[0].remove();
      target_table.fit(FitOptions.FRAME_TO_CONTENT);
   } catch(table_xml_error) {
      throw new Error("Problem with fill_description_table\n" + table_xml_error.line + " " + table_xml_error + "\n");
   }
}

function move_table(target_table, arr) {
   try {
     target_table.move(arr);
     return target_table;
   } catch(table_xml_error) {
      throw new Error("Problem with move_table " + table_xml_error.line + " " + table_xml_error + "\n");
   }
}

// function main() {
//     var table_template = get_table(component_page, test_template);
//     var new_table = place_table(last_page, table_template);
//     var section = doc.xmlElements[0].xmlElements[1].xmlElements[2].xmlElements;
//    
//     var tbl = doc.selection[0];
//     fill_table_xml(tbl, section);
      var doc = app.activeDocument;
// }
