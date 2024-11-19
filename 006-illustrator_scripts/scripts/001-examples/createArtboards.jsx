(function() {
   var doc = app.activeDocument;
   var artboards = doc.artboards;
   var list = ["Exterior Signage", "LCES", "LCIS", "Building Signage"];

   function getCsvPath() {

   }

   function parseCsv(path) {

   }

  try {
   function makeArtboards(list, rows){
      var boardDimensions = [0, 500, 500, 0];
      var left = boardDimensions[0];
      var height = boardDimensions[1];
      var right = boardDimensions[2];
      var bottom = boardDimensions[3];     
     
    for (var j = 0; j < rows; ++j) {
      for (var i = 0; i < list.length; ++i) {
         var newBoard;
         var horizontalOffset = 50;
         var horizontalSpacing;
         
         var verticalOffset = 50;
         var verticalSpacing;
         
         horizontalSpacing = i * (right - left + horizontalOffset);
         verticalSpacing = j * (height - bottom + verticalOffset);
         
         newBoard = artboards.add([left + horizontalSpacing, height + verticalSpacing, right + horizontalSpacing, bottom + verticalSpacing]);
         
         newBoard.name = list[i] + "-row " + j; 
      }
    }
   }
   makeArtboards(list, 3);
  } catch(e) {
     alert(e +"\n" + e.line);
  }
})();
