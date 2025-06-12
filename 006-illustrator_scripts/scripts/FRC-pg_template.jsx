// This is for the various template objects that will be used as modules in the FRC scripting library

// this is supposed to return an object that contains all of the page specfic objects that will later be targeted with XML data
function create_section_template(acronym_str, cmyk_arr, label_str, table_type_str) {
      var section_template = {};
      section_template.acronym = acronym_str;
      section_template.color_cmyk = cmyk_arr;
      section_template.table_type = table_type_str;
      section_template.label_type = label_str;
      return section_template;
   
}

 
// the template factory function is utilized here, creating a lookup table (dictionary) based on their section names so 
// conditional logic can be applied based on what the section is. 
function create_template_map() {
      // creates a dictionary of objects, refer to by the section name
   var section_template_map = {
         "entry": create_section_template("ENT", "ENTRY-RED", "<LABEL_ENTRY>", "<TARGET_TABLE_ENTRY>"),
         "lces": create_section_template("LCES", "LCES-GREEN", "<LABEL_LCES>", "<TARGET_TABLE_LCES>"),
         "lcis": create_section_template("LCIS", "LCIS-BLUE", "<LABEL_LCIS>", "<TARGET_TABLE_LCIS>"),
         "site": create_section_template("SITE", "SITE-ORANGE", "<LABEL_SITE>", "<TARGET_TABLE_SITE>"),
         "garage": create_section_template("GRG", "GRG-PURPLE", "<LABEL_GARAGE>", "<TARGET_TABLE_GARAGE>"),
         "building": create_section_template("BLDG", "BLDG-L_BLUE", "<LABEL_BUILDING>", "<TARGET_TABLE_BUILDING>"),
         "basement": create_section_template("BSMT", "BLDG-BLUE", "<LABEL_BUILDING>", "<TARGET_TABLE_BUILDING>"),
         "amenity": create_section_template("AMTY", "AMTY-YELLOW", "<LABEL_AMENITY>", "<TARGET_TABLE_AMENITY>"),
         "unit_ids": create_section_template("UNIT", "UNIT_ID-TEAL", "<LABEL_UNITS>", "<TARGET_TABLE_UNITS>"),
         "spotting": create_section_template("SPOTTING", "SPOTTING_ID-D_TEAL", "<LABEL_SPOTTING>", "TARGET_TABLE_SPOTTING>"),
         "addon": create_section_template("ADD", "ADD-MAGENTA", "<LABEL_ADDON>", "<TARGET_TABLE_ADDON>"),
         "collected": create_section_template("COLL", "COLL-TEAL", "<LABEL_COLL>", "<TARGET_TABLE_COLL>"),
         "id_mat": create_section_template("IDMAT", "IDMAT-GREY", "<LABEL_IDMAT>", "<TARGET_TABLE_IDMAT>"),
      
   }
      return section_template_map;
   
}


   // this is only used when we need to match the section name in the xml to a template. 
   // if we are creating the page regardless of whats in the xml we don't need this. 
   function choose_template(section_name_str, template_map) {
      try {
         var kw_regex_list = {
            "entry": /entry signage/gi,
            "leasing": /leasing center/gi,
            "exterior": /exterior/gi,
            "interior": /interior/gi,
            "site_sign": /site signage/gi,
            "building": /building/gi,
            "just_level": /level/gi,
            "single_family": /single family/gi,
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
         } else if (section_name_str.match(kw_regex_list.single_family)) {
            return template_map.building;
         } else if (section_name_str.match(kw_regex_list.amenity)) {
            return template_map.amenity;
         } else if (section_name_str.match(kw_regex_list.addon)) {
            return template_map.addon;
         } else if (section_name_str.match(kw_regex_list.basement)) {
            return template_map.basement;
         } else {
            return template_map.addon;
         }
      } catch(section_page_creation_err) {
         throw new Error("Error creating section page\n" + section_page_creation_err);
      }
   }


