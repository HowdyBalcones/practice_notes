try {
   var doc = app.activeDocument;
   var job_info = doc.xmlElements[0];
} catch(init_error) {
   throw new Error("Error during initilization in xml_data\n" + init_error);
}

function section_string(section_branch, section_id) {
   // this expects an xml branch for sections in the contract root
   var elements = section_branch.xmlElements;
   var elements_arr = [];
   var str = '';
   for (var i = 1; i < elements.length; ++i) {
      var section_name = elements[0].contents;
      var sign = elements[i].xmlElements;
      var key = sign[0].contents;
      var desc = sign[1].contents;
      var count = sign[2].contents;
      str += key + " " + desc + " " + " X " + count + "\n"; 
      // elements_arr.push(str);
   }
   //return elements_arr;
   return str;
}

function contract_to_aoa(root) {
   try {
      var arr = [];
      var contract = root.xmlElements[1].xmlElements;
      for (var i = 0; i < contract.length; ++i) {
         var section = contract[i].xmlElements;
         for (var j = 1; j < section.length; ++j) {
            var sub_arr = [];
            var sign = section[j].xmlElements;
            var section_name = section[0].contents;
            var key = sign[0].contents;
            var desc = sign[1].contents;
            var count = sign[2].contents;
            sub_arr.push(section_name);
            sub_arr.push(key);
            sub_arr.push(desc);
            sub_arr.push(count);
            arr.push(sub_arr);
         }
      }
   } catch(xml_error) {
      throw new Error("Error reading xml\n" + xml_error + " " + xml_error.line);
   }
   return arr;
}
