// This is for object definitions. They are complicating my function definitions. 
  // ---- Object Definitions ----

   function Client() {
        this.clientName = "";
        this.currentJobList = [];
        this.archivedJobList = [];
     }

   function Contract(data) {
        this.data = data;
     }

    function Section(name) {
        this.name = name;
        this.signList = [];
     }

   function Sign() {
      this.name = "";
      this.build = "implement stack!";
      this.dimensions = "itemBounds";
      this.profileView = "something based on build stack";

   }

// This brings information from the contract list into the section object
     Section.prototype.filterSections = function(list) {
        var mainList = parser(list);
        this.signList.push(mainList[2]);
     }

     Section.prototype.alertSections = function() {
      alert(this.signList.toString());
     }

   Section.prototype.makeBox = function() {
      var newBox = doc.textFrames.add();
      newBox.name = this.name + "-testing";
      newBox.contents = this.signList;
   }

        function Sign() {
        this.name = "";
        this.lineItem = "";
        this.count = 0;
        this.cost = 0;
        this.width = 0;
        this.height = 0;
        this.buildDescription = null;
     }


// ---- Object Testing ----
//  var testData = "name,age,city\nAlice, A,25,New York, NY\nBob,30,Chicago";
//  var testFilePath = '~/Desktop/practice_notes/006-illustrator_scripts/scripts/Sinclair-Testing.csv';
//  var testCsv = readFile(testFilePath);
//  var testList2 = parser(testCsv);
//
//  var testingSection = new Section("LCES");
//  testingSection.filterSections(testCsv);
//  testingSection.alertSections();
//
//

