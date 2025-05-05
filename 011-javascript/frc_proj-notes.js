// Goal: Layout the general structure and goals for our scripting library. 
//
// TODO: 
// General
//
// XML - database of sign contract information
// + convert to tree from literal text
// + create index/hashmap from tree
// + create initial or latest revision number when the tree is created
//
// + method to query the tree
// + method to update nodes of the tree
// + method to delete nodes 
// + method to add nodes to specific branches
// 
// + refactor XML parser to align with node, tree, and additonal abstractions
//    - may not be necessary, the parser is actually only to convert excel documents to xml. 
//    - we do need to be able to write from our xml abstractions, which can borrow components from the parser. 
//    - if we split up some of the components that might be easier. 
//
//
// MAP: 
// + tree = single contract
// + job info = root
// + metadata = branch
// + contract = branch
//    - section = branch
//       - sign = branch
//          - key = leaf
//          - description = leaf
//          - count = leaf
//          - cost = leaf
//          - total cost = leaf
// + unique sign list = branch
//    - unique sign = branch
//       - section list = branch
//          - section key = branch
//             - key = leaf
//             - section = leaf
// 
// QUESTIONS: 
// + what abstractions are absolutely necessary, and what is their purpose? 
// + what do we want to do with the database?
// + Does it need to be compatible with extendscript? -- I'm not sure. 
//    - Eventually, scripts will target the adobe programs as the main platform. 
//    - These programs will need to interact with the xml data in meaningful and consistent ways. 
//    - There is the currently used option, where modern js handles most of the heavy lifting for data. 
//    Extendscript basically should only be used for BASIC data tasks, on data that's already configured
//    to our purposes. Otherwise its utility comes from doing things in Adobe software, hard stop. 
//    - what will update in the books? 
//       > descriptions
//       > counts
//       > keys
//    - what will be added in the books? 
//       > new line items
//       > builds
//       > artwork 
//       > spotting images
//       > label identifiers
//       > level identifiers
//       > job notes
//       > splitting up tables
