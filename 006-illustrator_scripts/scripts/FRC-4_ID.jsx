(function() {
   var doc = app.activeDocument;
   if (!doc) {
      throw new Error("No open document to target\n");
   }

// TODO:
// - check if the main spread is set already, if not don't run
// - same for the create_section_page, which should be renamed create_section_master_pages
//   it also needs to check if the master pages already exist based on some value, and only create the neccesary ones
// - layout the needs for prompt_user_variable, which may end up using the template_page_object in order to set certain values
// - layout the plans for the template page object
// - tag the section spotting bubble objects
// - tag the section table objects
// - XML search function 
// - sign lookup tables, return instructions based on the matches 
// - master page script needs to name the actual master page more specifically, 
//   it also needs to create the spotting page name for the page title section

   /* 
   template_page_object - based on the section_template object but it needs to be more comprehensive
   various list of tags.
      
      + Handled by the master page script. 
      - section acronym
      - section color
      -- add section table type -- added to the section template, tag in template
      -- add section label type -- added to the section template, need to tag in the template correctly
      -- add spotting pages to the master page list -- use the spotting page label template but add the title block information w/ the word spotting
      -- add checks for existing master pages

      + Handled by the page making script
      -- how to estimate which page will receive which signs? 
      -- available artwork space
      -- placing sign description names onto the correct pages
      -- placing build names with their relevant signs, onto the correct pages
      -- labeling the signs according to the table data that is placed from xml 

      + How to build the build index 
      - stage 0: tag and establish build index functionality. That's - unique sign names can be brought into tables in the index, a user can fill the build description in the table
      - stage 1: import unique descriptions into the index tables, import collected signs into the index tables
      - stage 2: manually fill the build tables with the relevant sign builds? Tag the master index wth a class tag
      - stage 3: this is normally a manual process, where the proper builds are linked to the index table item
                 but it can be automated, so long as we can find every instance of the related sign throughout the book. 
      - stage 4: upload the build data to a section of the xml schema 
      - stage 5: any further changes or adjustments are either handled automatically through links between XML and index tables, or index tables and page objects
      -- not sure the exact setup, but there will be a master index table with every sign. This main index table will have a column for sign class.
         The sign class will correlate individual line items with their build. The build index table will have a 
         > How can we get the sign class tags to be consistent? Our use case doesn't take into account users yet. 
         > The build index table can perform a lookup on the master index table, if there is a description and cost match it can add the tag to the line item in the build index table 
         > a script to add line items with the same build to the same table

   */


// this adds the xml to the main parent spread. This was a lot of testing and figuring things out, not all of it gets used.
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

   // this is supposed to return an object that contains all of the page specfic objects that will later be targeted with XML data
   function create_section_template(acronym_str, cmyk_arr, label_str, table_type_str) {
      var section_template = {};
      section_template.acronym = acronym_str;
      section_template.color_cmyk = cmyk_arr;
      section_template.table_type = table_type_str;
      section_template.label_type = label_str;
      return section_template;
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
   
   // the template factory function is utilized here, creating a lookup table (dictionary) based on their section names so 
   // conditional logic can be applied based on what the section is. 
   function create_template_map() {
      // creates a dictionary of objects, refer to by the section name
      var section_template_map = {
         "entry": create_section_template("ENT", "ENTRY-RED", "LABEL_ENTRY", "TABLE_ENTRY"),
         "lces": create_section_template("LCES", "LCES-GREEN", "LABEL_LCES", "TABLE_LCES"),
         "lcis": create_section_template("LCIS", "LCIS-BLUE", "LABEL_LCIS", "TABLE_LCIS"),
         "site": create_section_template("SITE", "SITE-ORANGE", "LABEL_SITE", "TABLE_SITE"),
         "garage": create_section_template("GRG", "GRG-PURPLE", "LABEL_GARAGE", "TABLE_GARAGE"),
         "building": create_section_template("BLDG", "BLDG-L_BLUE", "LABEL_BUILDING", "TABLE_BUILDING"),
         "basement": create_section_template("BSMT", "BLDG-BLUE", "LABEL_BUILDING", "TABLE_BUILDING"),
         "amenity": create_section_template("AMTY", "AMTY-YELLOW", "LABEL_AMENITY", "TABLE_AMENITY"),
         "unit_ids": create_section_template("UNIT", "UNIT_ID-TEAL", "LABEL_UNITS", "TABLE_UNITS"),
         "spotting": create_section_template("SPOTTING", "SPOTTING_ID-D_TEAL", "LABEL_SPOTTING", "TABLE_SPOTTING"),
         "addon": create_section_template("ADD", "ADD-MAGENTA", "LABEL_ADDON", "TABLE_ADDON"),
         "collected": create_section_template("COLL", "COLL-TEAL", "LABEL_COLL", "TABLE_COLL"),
         "id_mat": create_section_template("IDMAT", "IDMAT-GREY", "LABEL_IDMAT", "TABLE_IDMAT"),
      }
      return section_template_map;
   }

   // goal here is to create a page with the spotting page template, but with the given sections information
   function create_spotting_page(current_section_template, template_map) {
      var spotting_template = template_map.spotting;
      alert(spotting_template.isValid);
   }

   function set_sub_spreads() {
      // this will duplicate the sub_spread template, rename the spread, fill the variable data, and continue for each section.  
      try {
         try {
            var root_elements = doc.xmlElements[0];      // the root of the contract tree, job info
            var contract_elements = root_elements.xmlElements[1].xmlElements;    // the contract section of job info, each section 
         } catch(xml_error) {
            // alert("Error reading xml" + xml_error);
            throw new Error("Error reading xml root\n" + xml_error);
         }
      var template_map = create_template_map(); 
      var sub_spread = doc.masterSpreads.itemByName("A-SUB-MAIN"); // this is how we target a specific spread in the template document
         // meat and potatoes of setting the master pages, this actually reads the XML data and correlates it with the template objects
         for (var i = 0; i < contract_elements.length; ++i) {
            var current_section_xml = contract_elements[i];
            var current_section_name = current_section_xml.xmlElements[0].contents;
            var current_section_name_xml = current_section_xml.xmlElements[0];
            var template_map_section = create_section_page(current_section_name, template_map); // this is the actual template that is going to be loaded based on the information in the XML
            
            // alert(current_section_xml.contents);
            // alert(template_map_section.acronym);            

            sub_spread.duplicate();

            var len = doc.masterSpreads.length;
            var newest_spread = doc.masterSpreads[len-1]; // we reference the duplicate of the sub_spread here, 

            var sheet_date = newest_spread.pageItems.itemByName("<SHEET_DATE>");    // here the various tagged elements of the page are created.
            var sheet_title = newest_spread.pageItems.itemByName("<TARGET_SHEET_TITLE>");
            var designer_initials = newest_spread.pageItems.itemByName("<DESIGNER_INITIALS>");
            var sheet_pg_label = newest_spread.pageItems.itemByName("<SHEET_PG_LABEL>");             
            try {
               // alert(sheet_pg_labels.constructor.name);
               if (sheet_date.isValid && sheet_title.isValid && sheet_pg_label.isValid) {
                  sheet_pg_label.fillColor = doc.colors.itemByName(template_map_section.color_cmyk);
                  sheet_pg_label.contents = sheet_pg_label.contents.replace("TEMP", template_map_section.acronym);
                  sheet_title.contents = current_section_name;
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

   function create_collected_pages() {
      try {
         try {
            var root_elements = doc.xmlElements[0];
            var contract_elements = root_elements.xmlElements[1].xmlElements;
            var grouped_elements = root_elements.xmlElements[2].xmlElements;
            if (grouped_elements) {
               // alert("truuue!");
               // alert(typeof grouped_elements);
            } else {
               // alert("capping!");
            }
         } catch(xml_error) {
            throw new Error("Error with xml\n" + xml_error);
         }
            var str;
            for (el in grouped_elements[0]) {
               str += el + "\n";
            }
         //alert(str);
         //alert(grouped_elements[0].contents);
         //alert(grouped_elements[0].xmlElements[0].contents);
         //alert(find_sign_in_xml(contract_elements, "stairwell"));
         var results;
         // alert(contract_elements.length + "\n" + contract_elements.count)
         for (var i = 0; i < contract_elements.length; ++i) {

            var section = contract_elements[i];
            alert(section);
            results = find_sign_in_xml(section, "stairwell");
         }
         alert(results);
         var stairwell_idx = find_sign_in_xml(contract_elements, "stairwell");

      } catch(collected_page_error) {
         throw new Error("Error creating collected pages\n" + collected_page_error);
      }
   }

   function find_sign_in_xml(root, term) {
     // an example of using the regexp object to implement variable matching, can't just create the regex literal
     // if (term.match(new RegExp(term, "gi"))) {
     //    alert("BIG TRUE");
     // }
      try {
         var match_arr = [];
         for (var i = 0; i < root.length; ++i) {
            var sign = root[i];
            var sign_name = root[i].contents;
            if (sign_name.match(new RegExp(term, "gi"))) {
               // str += sign_name + "\n";
               // alert("yes" + "\n" + sign.index)
               match_arr.push(sign.index);
            }
         }
         // alert(match_arr);
         return match_arr;
      } catch (loop_error) {
         throw new Error("Some error in xml search loop" + loop_error);
      }
   }

   // consider using xmlElement.convertElementToTable() method

   // this is only used when we need to match the section name in the xml to a template. 
   // if we are creating the page regardless of whats in the xml we don't need this. 
   function create_section_page(section_name_str, template_map) {
      try {
         var kw_regex_list = {
            "entry": /entry signage/gi,
            "leasing": /leasing center/gi,
            "exterior": /exterior/gi,
            "interior": /interior/gi,
            "site_sign": /site signage/gi,
            "building": /building/gi,
            "just_level": /level/gi,
            "basement": /basement/gi,
            "garage": /garage/gi,
            "amenity": /amenity/gi,
            "addon": /addon/gi
         }
         if (section_name_str.match(kw_regex_list.entry)) {
            return template_map.entry;
         } else if (section_name_str.match(kw_regex_list.leasing) && section_name_str.match(kw_regex_list.exterior)) {
            return template_map.lces;
         } else if (section_name_str.match(kw_regex_list.leasing) && section_name_str.match(kw_regex_list.interior)) {
            return template_map.lcis;
         } else if (section_name_str.match(kw_regex_list.site_sign)) {
            return template_map.site;
         } else if (section_name_str.match(kw_regex_list.garage)) {
            return template_map.garage;
         } else if (section_name_str.match(kw_regex_list.building)) {
            return template_map.building;
         } else if (section_name_str.match(kw_regex_list.just_level)) {
            return template_map.building;
         } else if (section_name_str.match(kw_regex_list.amenity)) {
            return template_map.amenity;
         } else if (section_name_str.match(kw_regex_list.addon)) {
            return template_map.addon;
         } else if (section_name_str.match(kw_regex_list.basement)) {
            return template_map.basement;
         }
      } catch(section_page_creation_err) {
         throw new Error("Error creating section page\n" + section_page_creation_err);
      }
   }

   function prompt_user_variables() {

   }


   try {
      //find_sign_in_xml(grouped_elements, "stairwell");
      create_collected_pages();
      //set_main_spread();
      //create_add_frc_colors();
      //set_sub_spreads();
      // test_xml_elements();
      // test_import_xml();
   } catch(main_err) {
      throw new Error('Error with main script\n' + main_err);
   }
}())
