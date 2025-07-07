try {
   var doc = app.activeDocument;
} catch(main_error) {
   throw new Error("Problem in test.jsx" + main_error.line + " " + main_error);
}

// want to create something that will point out where a target is in the dom tree
function iterate_object(target) {
   var str;
   for (var item in target) {
      if (target[item] === undefined) {
         break;
      }
      str += item + " -- " + target[item] + "\n";
   }
   return str;
}

// testing xpath inside the extendscript language
function xpath_test(target) {
   var book = doc.xmlElements[0];
   var book_contents_xml = new XML(book.contents);
   var root_contract = book.evaluateXPathExpression("/job_info/metadata")
   var metadata = book.evaluateXPathExpression("//metadata/project_name");
   var contract = book.evaluateXPathExpression("//contract");
   var section_one = book.evaluateXPathExpression("//contract/section");
   var section_two = book.evaluateXPathExpression("//contract/section")
   var all_signs = book.evaluateXPathExpression("//section/sign")
   var all_sections = book.evaluateXPathExpression("//contract/section");
   // var check_parent = root_contract.evaluateXPathExpression("/../contract")
   // alert(metadata.constructor.name);
  //  alert(metadata[0].contents);
  //  alert(section_one[0].contents);
  //  alert(section_two[1].contents)
  //  alert(metadata.length);
  //  alert(root_contract[0].contents);
  //  alert(all_signs.length);
   alert(all_sections.length);
   
   var str = "";
   var str2 = "";
  // for (var i = 0; i < all_signs.length; ++i) {
  //    var sign = all_signs[i];
  //    var description = sign.evaluateXPathExpression("/sign/description");
  //    // var current_section = sign.evaluateXPathExpression("/..")
  //    // str += current_section[0].contents + " -- " + description[0].contents + "\n";
  //    //str += sign.evaluateXPathExpression("/sign/description") + "\n";
  // }
   
   for (var i = 0; i < all_sections.length; ++i) {
      var section = all_sections[i];
      var section_name = section.evaluateXPathExpression("/section/section_name");
      var append_test = section.evaluateXPathExpression("/section/")
      str += section_name[0].contents + "\n";
   }
   alert(str);
}

function xpath_vanilla() {
   var book = doc.xmlItems[0];
   alert(book.constructor.name);
  // var contract = xml_book.xpath("//contract");
  // alert(contract[0].contents);
}

function book_play() {
   // https://helpx.adobe.com/indesign/using/creating-book-files.html?x-product=Helpx%2F1.0.0&x-product-location=Search%3AForums%3Alink%2F3.7.0
   var book = app.books[0];
   alert(book.fullName);
   alert(iterate_object(book.eventListeners));
}

function main() {
   alert("testing");
   // book_play();
   xpath_test(0);
   // xpath_vanilla();
}

main();
