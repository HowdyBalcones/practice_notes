try {

      function find_position(target_page, target_item) {
         //alert(doc.spreads[0].allPageItems);
         target_page = doc.pages[0];
         for (var i = 0; i < target_page.masterPageItems.length; ++i) {
            var item = target_page.masterPageItems[i];
            if (item.name === "<PLACE_TARGETS>") {
               var col1r1 = item.groups[0].pageItems[0];
               //col1r1.fillColor = doc.swatches.itemByName("[Black]");
               alert(col1r1.locked);
            }
         }
      }

      function make_position_map(target_spread) {
         // returns an AoA, map[col#][row#]
         // target_spread = doc.masterSpreads[1]; // usually A-SUB-MAIN will have the placement grid
         var place_targets = target_spread.pageItems.itemByName("<PLACE_TARGETS>");
         var map = [];
         for (var i = 0; i < place_targets.groups.length; ++i) {
            var col = place_targets.groups[i];
            var row_arr = []; 
            for (var j = 0; j < col.pageItems.length; ++j) {
               var row = col.pageItems[j];
               row_arr.push(row);
            }
            map.push(row_arr);
         }
         return map;
         // alert(map[0][0].geometricBounds);
      }

} catch(position_error) {
   throw new Error("Problem in position_tools\n" + position_error.line + " " + position_error);
}
