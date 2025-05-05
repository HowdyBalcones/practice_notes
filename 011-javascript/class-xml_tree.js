class xml_tree {
   constructor(xml_data) {
      this.tree = null // function to convert the xml data to a tree structure
      this.index = null // function to build hashmap for the data. Faster query. 
      this.revision = null // something to compare literal xml with abstracted class and create rev numbers
   }

   readXml(xml) {
      // parse the xml data, turn into nodes
   }

   writeXml(destination) {
      // call the xml parser and write a literal xml file based on the data in our abstraction
   }

   queryXml(search_term, filter_arr) {
      // search the tree, only search for items based on filters
   }

   jobSortXml(sort_method) {
      // there will be different ways we need to sort through contract data, and then attach that new list to 
      // an XML file in the database. 
   }

}
