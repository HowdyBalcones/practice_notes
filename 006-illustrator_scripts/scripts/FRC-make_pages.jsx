(function() {
   try {
      var doc = app.activeDocument;
      var job_info = doc.xmlElements[0];
      #include './FRC-make_tables.jsxinc';
      #include './FRC-xml_data.jsxinc';
      #include './FRC-pg_template.jsxinc';
      #include './FRC-make_master_pages.jsxinc';
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
      
      // fix the master page mutating when we change sheet_title.contents
      function make_pages() {
         //alert(doc.masterSpreads.length);          
         //alert(doc.masterSpreads.itemByName("A-SUB-MAIN").id);
         var sub_spread = doc.masterSpreads.itemByName("A-SUB-MAIN");
         var sub_index_offset = sub_spread.index + 2;
         
         var first_page = doc.pages[1];
         var index_start = doc.pages[2];

         var regex_signage = /signage/i

         for (var i = sub_index_offset; i < doc.masterSpreads.length; ++i) {
            var current_master = doc.masterSpreads[i];
            var current_page = doc.pages.add(LocationOptions.BEFORE, index_start);
            current_page.appliedMaster = current_master;
            var sheet_title;
            for (var j = 0; j < current_page.masterPageItems.length; ++j) {
               var master_page_item = current_page.masterPageItems[j];
               if (master_page_item.name === "<TARGET_SHEET_TITLE>") {
                  master_page_item.override(current_page);
                  sheet_title = master_page_item;
                  continue;
                  //alert('found')
               }
            }
            //var sheet_title = current_page.masterPageItems.itemByName("<TARGET_SHEET_TITLE>");
            //alert(sheet_title.contents);
            
             sheet_title.texts[0].contents.replace(regex_signage, "Spotting");
            alert(current_page.name + "\n" + sheet_title.contents);
         }
         alert(doc.pages[1].name);
      }

      function main() {
        // var test = contract_to_aoa(job_info);
        // alert(test);
        var test_str = "#10: etc etc etc";
        var regex_test = /\#\d*\:/gi
        // alert(test_str.match(regex_test));
        // alert(test_str.replace(regex_test, ''));

         //test_page()
         make_pages();
      }

      main();

   } catch(main_error) {
      throw new Error("Main error in make_pages\n" + main_error);
   }
   
})()
