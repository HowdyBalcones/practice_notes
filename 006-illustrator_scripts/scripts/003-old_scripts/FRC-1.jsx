
(function() {
   try {
      var doc = app.activeDocument; 
   } catch(e) {
      alert("No active document")
   }

   var textFrame = doc.textFrames.add();
   var layer = doc.layers;
   var numLayers = 5;
   var givenList = ["First", "Second", "Third"];

   function makeText() {
      textFrame.contents = "Hello World!"
      textFrame.textRange.characterAttributes.size = 20;
      textFrame.top = 200;
      textFrame.left = 100;
   }
   
   // this will add new layers to the doc in a given sequence. 
   function addLayers(numLayers) {
      var newLayer = layer.add();
      for (var i = 0; i < 5; ++i) {
         testAdd = doc.layers.add();
         testAdd.name = "Testing-" + [i];
      }
   }
   
   function layerName() {
      selectedLayer = doc.activeLayer;
      selectedLayer.name = "Renamed_Layer"
   }

   // uses the remove() method
   function deleteLayer() {
      selectedLayer = doc.activeLayer;
      selectedLayer.remove();
   }

   // uses the add() method, passes list to layer name
   function layerListName(list) {
      for (var i = 0; i < list.length; ++i) {
         var newLayer = layer.add();
         newLayer.name = list[i];

      }
   }

   function storyTest() {
      
      alert(doc.stories[0].characters.length);
       
      doc.stories[0].characters.removeAll();
      // alert(doc.stories[0].length);

   }

   function labelTest() {
      var temp = doc.selection[0].tags.add();
      temp.name = "HELLO";
      temp.value = "Hello!!";
      alert(temp.name);
      alert(temp.value);
   }

   function listTags() {
      var tagsList = "";
      for (var i = 0; i < doc.tags.length; ++i) {
            var item = doc.tags[i];
            tagsList += item.name + "\n";
      }
      alert(tagsList)
   }

   function cameraTest(item) {
      if (!item) {
        alert("No valid item selected.");
        return;
      }
      doc.selection = [item];
      var bounds = item.visibleBounds;
      var centerX = (bounds[0] + bounds[2]) / 2;
      var centerY = (bounds[1] + bounds[3]) / 2;
      var activeView = doc.activeView;
      
      activeView.centerPoint = [centerX, centerY];
   }
   // this is the template for making classes in extendscript
   // goal here is to create a section and sign classi
   // below instantiates the object
   function ObjectTest(data) {
      this.data = data;
   }
   // this adds a describe method to the ObjectTest
   ObjectTest.prototype.describe = function() {
      return this.data + "\n";
   }
   // makes a new ObjectTest with value of "Hello World!" and calls describe method in an alert
   var testObj = new ObjectTest("Hello World!");
   alert(testObj.describe());

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

   // some filter methods for Section
   Section.prototype.filterSections = function(list) {
      for (var i = 0; i < list.length; ++i) {
         var cols = list[i];
         if (cols[0] === this.name) {
            this.signList.push(this.name + "-" + cols[1] + "-" + cols[2] + "-" + cols[3]) 
         }
      }
   }

   Section.prototype.alertSections = function() {
    alert(this.signList.toString());  
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

   Section.prototype.addSigns = function(list) {

   }

// ---- Function Testing ----
//   makeText();
//   addLayers(numLayers);
//   layerName();
//   deleteLayer();
//   layerListName(givenList);
//   alert("Hello World");
//   storyTest();

// labelTest();
// cameraTest(doc.selection[0]);
// listTags();
// ---- Object Testing ----
   var testSection = new Section("LCES");
   testingPrompt();
})();
