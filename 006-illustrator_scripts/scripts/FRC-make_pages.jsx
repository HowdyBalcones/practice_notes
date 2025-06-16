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
      
      // this was the prototype, use xml_make_page();
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

            
            function make_spotting_page() {
               var xml_section = doc.xmlItems[0].xmlItems[1].xmlItems[i]
               var spotting_page = current_page.duplicate(LocationOptions.AFTER, current_page); 
               var spotting_sheet_title = spotting_page.pageItems.itemByName("<TARGET_SHEET_TITLE>");
               spotting_sheet_title.contents = spotting_sheet_title.contents.replace(regex_signage, "SPOTTING");
               var spotting_table = get_table(component_page, template_object)
            }
            make_spotting_page();
         }
         alert(doc.pages[1].name);
      }

      // main page making function, combines all of the utility functions as it loops through the contract.
      function xml_make_page() {
         var component_page = doc.spreads[0];
         var description_table = get_generic_table(component_page, "<DESCRIPTION_TABLE>");
         var sub_main = doc.masterSpreads.itemByName("A-SUB-MAIN");
         var contract = doc.xmlItems[0].xmlItems[1].xmlItems;

         var first_page = doc.pages[1];
         var index_start = doc.pages[2];
         
         var template_map = create_template_map();
         var pos_map = make_position_map(sub_main);

         var pos = pos_map[0][0];
         var pos2 = pos_map[5][0];
         var table_pos = [pos.geometricBounds[1], pos.geometricBounds[0]];
         var label_pos = [pos2.geometricBounds[1], pos2.geometricBounds[0]];
         
         var regex_signage = /SIGNAGE/i
         alert("test1")

         for (var i = 0; i < contract.length; ++i) {
            var current_section = contract[i].xmlItems;
            var current_section_name = contract[i].xmlItems[0].contents;
            alert("test2")
            var current_master = search_master_spreads(current_section_name); 
            alert(current_master.index)
            var current_page = doc.pages.add(LocationOptions.BEFORE, index_start);
            current_page.appliedMaster = current_master;

            for (var j = 0; j < current_page.masterPageItems.length; ++j) {
               var master_page_item = current_page.masterPageItems[j];
               if (master_page_item.name === "<SECTION_TITLE>") {
                  alert(master_page_item.name);
                  master_page_item.override(current_page);
                  master_page_item.detach();
               } else if (master_page_item.name === "<TARGET_SHEET_TITLE>") {
                  master_page_item.override(current_page);
                  master_page_item.detach();
                  break;
               }
            }
           // alert(current_page.pageItems.itemByName("<SECTION_TITLE>"));
           // var testing = current_page.pageItems.itemByName("<SECTION_TITLE>")
           // alert(testing.contents);
            var section_title = current_page.pageItems.itemByName("<SECTION_TITLE>")
            alert("test3")
            alert(section_title.constructor.name);
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
                  var template_label = get_label(component_page, template_object, false);
                  var new_label = place_label(spotting_page, template_label);
                  fill_and_arrange_labels(new_label, current_section, label_pos, true);
               } catch(spotting_pg_error) {
                  throw new Error("Error creating spotting page\n" + spotting_pg_error + " " + spotting_pg_error.line);
               }
            }
            make_spotting_page();

            var new_gen_table = place_table(current_page, description_table);
            fill_description_table(new_gen_table, current_section);
            move_table(new_gen_table, table_pos);
            var template_label = get_label(component_page, template_object, true);
            var new_label = place_label(current_page, template_label);
            fill_and_arrange_labels(new_label, current_section, label_pos, false);
            alert("Page Complete: " + current_section_name + "\n");
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

      // target_page refers to a page with the source templates, here usually the component_page
      function get_label(target_page, section_template, spot_bool) {
         try {
            var all_components = target_page.pageItems;
            var big_labels = all_components.itemByName("<LABELS-SPOTTING>").groups.itemByName("<BIG_LABELS>").groups;
            var small_labels = all_components.itemByName("<LABELS-SPOTTING>").groups.itemByName("<SMALL_LABELS>").groups;
            var target_labels = section_template.label_type;

            if (spot_bool) {
               // use big
               for (var i = 0; i < big_labels.length; ++i) {
                  var template_label_type = big_labels[i].name;
                  if (template_label_type === undefined) {
                     alert("read problem")
                     break;
                  } else if (template_label_type === target_labels) {
                     return big_labels[i];
                  }
               }
            } else {
               // use small
               for (var i = 0; i < small_labels.length; ++i) {
                  var template_label_type = small_labels[i].name;
                  if (template_label_type === undefined) {
                     alert("read problem")
                     break;
                  } else if (template_label_type === target_labels) {
                     return small_labels[i];
                  }
               }
            }
         } catch(label_error) {
            throw new Error("problem with get_label" + label_error.line + " " + label_error + "\n");
         }
      }

      function place_label(target_spread, label) {
         if (!label) {
            throw new Error("No label in place_label\n");
         }
         var new_label = label.duplicate(target_spread);
         new_label.move([-1, 0]);
         return new_label;
      }

      // make the spotting bubbles for actual spotting pages here
      function fill_and_arrange_labels(target_labels, section, position, spot_bool) {
         try {
            var every_label = target_labels.groups;
            var single_bubble, unique_bubble;
            var regex_key = /^[A-Za-z]+/i
            var y_offset = position[1];
            var x_offset = position[0];
            for (var i = 0; i < every_label.length; ++i) {
               var label = every_label[i];
               if (label.name === "<U-BUBBLE>") {
                  unique_bubble = label;
                  //alert(unique_bubble.name);
               } else if (label.name === "<S-BUBBLE>") {
                  single_bubble = label;
                  //alert(single_bubble.name);
               }
            }
            for (var i = 0; i < section.length; ++i) {
               var section_name;
               if (section[i].markupTag.name === "section_name") {
                  section_name = section[i].contents;
                  continue;
               }
               var sign = section[i].xmlElements;
               var key = sign[0].contents.match(regex_key).toString();
               
               function big_bbl() {
                  var count = sign[2].contents;
                  var bubble_key = single_bubble.groups[0].pageItems[1];
                  var bubble_count = single_bubble.pageItems[1];
                  bubble_key.contents = key;
                  bubble_count.contents = "X " + count
                  if (i % 5 === 0) {
                     y_offset += 0.5;
                     x_offset -= 5;
                  }
                  single_bubble.duplicate([x_offset + i, y_offset]);
               }

               function small_bbl() {
                  var single_down = every_label[6];

                  var bubble_key = single_down.groups[0].pageItems[1];
                  bubble_key.contents = key;
                  if (i % 5 === 0) {
                     y_offset += 1.25;
                     x_offset -= 5;
                  }
                  single_down.duplicate([x_offset + i, y_offset]);
                  //alert(bubble_key.isValid);
               }
               if (spot_bool) {
                  small_bbl();
               } else {
                  big_bbl();
               }
            }
         //alert("done");
         } catch(label_error) {
            throw new Error("Problem with fill_and_arrange_labels\n" + label_error.line + " " + label_error);
         }

      }

      function main() {
        // var test = contract_to_aoa(job_info);
        // alert(test);
       // var test_template = create_template_map();
       // var test_xml_section = doc.xmlElements[0].xmlElements[1].xmlElements[2].xmlElements;
       // var test_section_template = choose_template("leasing center exterior", test_template);
       // var test_section_name = "#19: LEVEL 6 SIGNAGE"
       // var test_str = "#10: etc etc etc";
       // var regex_test = /\#\d*\:/gi
       // var test_spread = doc.masterSpreads.itemByName("A-SUB-MAIN");
       // var test_pages = doc.pages[1];
        //alert(test_str.match(regex_test));
        //alert(test_str.replace(regex_test, ''));
        //search_master_spreads(test_section_name);
        //test_page()
        set_main_spread();
        //create_add_frc_colors();
        set_sub_spreads();
        xml_make_page();
        //find_position(1, 1);
        //var pos_map = make_position_map(test_spread);
        //var y1 = pos_map[0][0].geometricBounds[0];
        //var x1 = pos_map[0][0].geometricBounds[1];
        //var test_label = get_label(0, test_section_template, true);
        //var new_label = place_label(test_pages, test_label);
        //fill_and_arrange_labels(new_label, test_xml_section, [4,4]);
        //alert(test_spread.name);
         
      }

      main();

   } catch(main_error) {
      throw new Error("Main error in make_pages\n" + main_error);
   }
   
})()
