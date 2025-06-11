try {
   var doc = app.activeDocument;

   // a function to create any desired indesign CMYK swatch
   function create_cmyk_swatch(name_str, cmyk_arr, color_space_obj) {
      var col = {};
      col.name = name_str;
      col.colorValue = cmyk_arr;
      col.space = color_space_obj;
      return col;
   }

   function testing_find_swatch() {
      alert(doc.swatches[3].name);
   }

   function main() {
      // alert("hello world")
     testing_find_swatch(); 

   }
   main()

} catch(color_error) {
   throw new Error("Problem in color_tools\n" + color_error.line + "\n" + color_error + "\n");
}
