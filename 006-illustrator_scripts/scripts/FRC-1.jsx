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
//   makeText();
//   addLayers(numLayers);
//   layerName();
//   deleteLayer();
//   layerListName(givenList);
//   alert("Hello World");
   storyTest();
})();
