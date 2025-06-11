(function() {
   try {
      var doc = app.activeDocument;
      var job_info = doc.xmlElements[0];
      #include './FRC-make_tables.jsxinc';
      #include './FRC-xml_data.jsxinc';
      #include './FRC-pg_template.jsxinc';
      #include './FRC-make_master_pages.jsxinc';
      #include './FRC-position_tools.jsxinc';
      if (!doc) {
         throw new Error("No active document\n")
      }
   } catch (init_error) {
      throw new Error("Init error in make_pages\n" + init_error);
   }

   try {
     // alert("hello")
      // goal: test adding pages, setting master page, switching on template dictionary

      function test_page(template_obj) {
         var last_page = doc.pages[-1];
         var template_page = doc.pages[1];
         //alert(last_page.id);
         var last_master = doc.masterSpreads[-1];
         last_page.appliedMaster = last_master;
         for (var i = 0; i < 3; ++i) {
            doc.pages.add(LocationOptions.AT_END, last_master);
            alert(new_page.id);
         }
      }
      
      function make_pages() {
         var sub_spread = doc.masterSpreads.itemByName("A-SUB-MAIN");
         var component_page = doc.spreads[0];
         var sub_index_offset = sub_spread.index + 2;
         
         var first_page = doc.pages[1];
         var index_start = doc.pages[2];

         var template_map = create_template_map();

         var regex_signage = /SIGNAGE/i

         for (var i = sub_index_offset; i < 5; ++i) {
            var current_master = doc.masterSpreads[i];
            var current_page = doc.pages.add(LocationOptions.BEFORE, index_start);
            current_page.appliedMaster = current_master;
            for (var j = 0; j < current_page.masterPageItems.length; ++j) {
               var master_page_item = current_page.masterPageItems[j];
               if (master_page_item.name === "<TARGET_SHEET_TITLE>") {

                  master_page_item.override(current_page);
                  master_page_item.detach();
                  break;
               }
            }
            var sheet_title = current_page.pageItems.itemByName("<TARGET_SHEET_TITLE>");

            var template_object = choose_template(sheet_title.contents, template_map);
           // alert(template_object.acronym);
            
            // this either needs to search the xml for a matching section, or the main loop needs to iterate 
            // through the section and not the master pages. This may be something that gets addressed in a separate function. 
            function make_spotting_page() {
               var xml_section = doc.xmlItems[0].xmlItems[1].xmlItems[i]
               var spotting_page = current_page.duplicate(LocationOptions.AFTER, current_page); 
               var spotting_sheet_title = spotting_page.pageItems.itemByName("<TARGET_SHEET_TITLE>");
               spotting_sheet_title.contents = spotting_sheet_title.contents.replace(regex_signage, "SPOTTING");
               var spotting_table = get_table(component_page, template_object)
              // place_table(spotting_page, spotting_table);
              // fill_table_xml(spotting_table, xml_section);
                
            }
            make_spotting_page();
         }
         alert(doc.pages[1].name);
      }

      function xml_make_page() {
         var component_page = doc.spreads[0];
         var sub_main = doc.masterSpreads.itemByName("A-SUB-MAIN");

         var contract = doc.xmlItems[0].xmlItems[1].xmlItems;

         var first_page = doc.pages[1];
         var index_start = doc.pages[2];
         
         var template_map = create_template_map();
         var pos_map = make_position_map(sub_main);
         
         var regex_signage = /SIGNAGE/i

         for (var i = 0; i < 5; ++i) {
            var current_section = contract[i].xmlItems;
            var current_section_name = contract[i].xmlItems[0].contents;
            var current_master = search_master_spreads(current_section_name); 
            var current_page = doc.pages.add(LocationOptions.BEFORE, index_start);
            current_page.appliedMaster = current_master;

            for (var j = 0; j < current_page.masterPageItems.length; ++j) {
               var master_page_item = current_page.masterPageItems[j];
               if (master_page_item.name === "<SECTION_TITLE>") {
                  master_page_item.override(current_page);
                  master_page_item.detach();
               } else if (master_page_item.name === "<TARGET_SHEET_TITLE>") {
                  master_page_item.override(current_page);
                  master_page_item.detach();
                  break;
               }
            }
            var section_title = current_page.pageItems.itemByName("<SECTION_TITLE>")
            
            var template_object = choose_template(section_title.contents, template_map);

            function make_spotting_page() {
               try {
                  
                  var spotting_page = current_page.duplicate(LocationOptions.AFTER, current_page);
                  var spotting_sheet_title = spotting_page.pageItems.itemByName("<TARGET_SHEET_TITLE>");
                  spotting_sheet_title.contents = spotting_sheet_title.contents.replace(regex_signage, "SPOTTING");
                  
                  var spotting_table = get_table(component_page, template_object);
                  if (spotting_table === undefined) {
                     alert("no table\n" + "Template: " + template_object.table_type);
                     return;
                  }
                  var new_table = place_table(spotting_page, spotting_table);

                  fill_table_xml(new_table, current_section);
                  var pos = pos_map[0][0];
                  var table_pos = [pos.geometricBounds[1], pos.geometricBounds[0]];
                  move_table(new_table, table_pos);
               } catch(spotting_pg_error) {
                  throw new Error("Error creating spotting page\n" + spotting_pg_error + " " + spotting_pg_error.line);
               }
            }
            make_spotting_page();
         }
      }

      function search_master_spreads(target) {
         try {
            for (var i = 3; i < doc.masterSpreads.length; ++i) {
               var current_spread = doc.masterSpreads[i];
               var section_name = current_spread.pageItems.itemByName("<SECTION_TITLE>");
               if (section_name.contents === target) {
                  return current_spread;
               }
            }
         } catch(search_error) {
            throw new Error("Error in search\n" + search_error + " " + search_error.line);
         }
        
      }

      function main() {
        // var test = contract_to_aoa(job_info);
        // alert(test);
        var test_section_name = "#19: LEVEL 6 SIGNAGE"
        var test_str = "#10: etc etc etc";
        var regex_test = /\#\d*\:/gi
        //var test_spread = doc.masterSpreads.itemByName("A-SUB-MAIN");
        // alert(test_str.match(regex_test));
        // alert(test_str.replace(regex_test, ''));
         //search_master_spreads(test_section_name);
         //test_page()
         //set_main_spread();
         //create_add_frc_colors();
         //set_sub_spreads();
          //make_pages();
          xml_make_page();
         //find_position(1, 1);
         //var pos_map = make_position_map(test_spread);
        // var y1 = pos_map[0][0].geometricBounds[0];
        // var x1 = pos_map[0][0].geometricBounds[1];

         //alert(test_spread.name);
         
      }

      main();

   } catch(main_error) {
      throw new Error("Main error in make_pages\n" + main_error);
   }
   
})()
