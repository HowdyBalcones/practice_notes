try {
   var doc = app.activeDocument;
   #include './FRC-pg_template.jsxinc';
} catch(master_pg_error) {
   throw new Error("Problem in make_master_pages\n" + master_pg_error.line + " " + master_pg_error);
}
try {
 
   // consider condensing
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
   }

   // a function to create any desired indesign CMYK swatch
   function create_cmyk_swatch(name_str, cmyk_arr, color_space_obj) {
      var col = {};
      col.name = name_str;
      col.colorValue = cmyk_arr;
      col.space = color_space_obj;
      return col;
   }

   // creates the frc_colors object, then checks the doc to see if they're already there. 
   function create_add_frc_colors() {
      try {
         var frc_colors = [
         create_cmyk_swatch("ENTRY-RED", [15,100,100,0], ColorSpace.CMYK), 
         create_cmyk_swatch("LCES-GREEN", [75,5,100,0], ColorSpace.CMYK),
         create_cmyk_swatch("LCIS-BLUE", [100,90,10,0], ColorSpace.CMYK),
         create_cmyk_swatch("SITE-ORANGE", [0,50,100,0], ColorSpace.CMYK),
         create_cmyk_swatch("GRG-PURPLE", [50,90,0,0], ColorSpace.CMYK),
         create_cmyk_swatch("BLDG-L_BLUE", [100,0,0,0], ColorSpace.CMYK),
         create_cmyk_swatch("AMTY-YELLOW", [0,0,100,0], ColorSpace.CMYK),
         create_cmyk_swatch("ADD-MAGENTA", [0,100,0,0], ColorSpace.CMYK),
         create_cmyk_swatch("UNIT_ID-TEAL", [59,2,44,0], ColorSpace.CMYK),
         create_cmyk_swatch("SPOTTING_ID-D_TEAL", [59, 2, 44, 0], ColorSpace.CMYK),
         create_cmyk_swatch("COLL-TEAL", [80, 10, 45, 0], ColorSpace.CMYK),
         create_cmyk_swatch("IDMAT-GREY", [0, 0, 0, 35], ColorSpace.CMYK),
         ]
         // checks if the swatches already exist in the target doc, if not adds them
         for (var i = 0; i < frc_colors.length; ++i) {
            var swatch = frc_colors[i];

            if (doc.colors.itemByName(swatch.name).isValid) {
               continue;
            }
            doc.colors.add(swatch);
         }
      } catch(color_error) {
         throw new Error("Error generating colors\n" + color_error);
      }
      
   }

  function set_sub_spreads() {
      try {
         try {
            var root_elements = doc.xmlElements[0];      
            var contract_elements = root_elements.xmlElements[1].xmlElements;
         } catch(xml_error) {
            throw new Error("Error reading xml root\n" + xml_error);
         }
      var template_map = create_template_map(); 
      var sub_spread = doc.masterSpreads.itemByName("A-SUB-MAIN"); 
      var regex_section_num = /\#\d*\:/;
         for (var i = 0; i < contract_elements.length; ++i) {
            var current_section_xml = contract_elements[i];
            var current_section_name = current_section_xml.xmlElements[0].contents;
            var current_section_name_xml = current_section_xml.xmlElements[0];
            var template_map_section = choose_template(current_section_name, template_map); 

            sub_spread.duplicate();

            var len = doc.masterSpreads.length;
            var newest_spread = doc.masterSpreads[len-1]; 

            var sheet_date = newest_spread.pageItems.itemByName("<SHEET_DATE>");    
            var sheet_title = newest_spread.pageItems.itemByName("<TARGET_SHEET_TITLE>");
            var designer_initials = newest_spread.pageItems.itemByName("<DESIGNER_INITIALS>");
            var sheet_pg_label = newest_spread.pageItems.itemByName("<SHEET_PG_LABEL>");             
            try {
               if (sheet_date.isValid && sheet_title.isValid && sheet_pg_label.isValid) {
                  sheet_pg_label.fillColor = doc.colors.itemByName(template_map_section.color_cmyk);
                  sheet_pg_label.contents = sheet_pg_label.contents.replace("TEMP", template_map_section.acronym);
                  sheet_title.contents = current_section_name.replace(regex_section_num, '');
                  newest_spread.baseName = template_map_section.acronym;
               }
            } catch(sub_spread_obj_error) {
               throw new Error("Error referencing sub_spread pageItems\n" + sub_spread_obj_error);
            }
         }
      } catch(sub_spread_error) {
         alert("Error in sub_spread function" + sub_spread_error.message);
         throw new Error("Error in sub_spread\n" + sub_spread_error);
      }
   } 

//   function main() {
//     // set_main_spread();
//     // create_add_frc_colors();
//     // set_sub_spreads();
//
//
//   }

 
} catch(master_pg_error_main) {
   throw new Error("Problem in make_master_pages\n" + master_pg_error_main.line + " " + master_pg_error_main);
}
