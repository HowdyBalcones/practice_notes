(function() {
   try {
      var doc = app.activeDocument;
      var job_info = doc.xmlElements[0];
      #include './FRC-make_tables.jsxinc';
      #include './FRC-xml_data.jsxinc';
      #include './FRC-pg_template.jsxinc';
      if (!doc) {
         throw new Error("No active document\n")
      }
   } catch (init_error) {
      throw new Error("Init error in make_pages\n" + init_error);
   }

   try {
     // alert("hello")

      function test_page(template_obj) {

      }
      
      function make_pages() {
          
      }

      function main() {
        // var test = contract_to_aoa(job_info);
        // alert(test);
        var test_str = "#10: etc etc etc";
        var regex_test = /\#\d*\:/gi
        // alert(test_str.match(regex_test));
        alert(test_str.replace(regex_test, ''));
      }

      main();

   } catch(main_error) {
      throw new Error("Main error in make_pages\n" + main_error);
   }
   
})()
