(function() {
   var doc = app.activeDocument;
   var textArr = [];
   var groupNameArr = [];
   var sectionList = ["Entry_Signage", "LCES", "LCIS", "Site_Signage", "Clubhouse", "Fitness"]
   try {
      function addText(textItem) {
         textArr.push(textItem);
      }

      function loopGroup(group) {
         for (var i = 0; i < group.groupItems.length; ++i) {
            item = group.pageItems[i];
            if (item.typename === "TextFrame") {
               addText(item);
            } else if (item.typename === "GroupItem") {
               loopGroup(item);
            }
         }
      };

      function loopPage(container) {
         for (var i = 0; i < container.pageItems.length; ++i) {
            var item = container.pageItems[i];
            if (item.typename === "TextFrame") {
               addText(item);
            } else if (item.typename === "GroupItem") {
               loopGroup(item)
            }
         }
      };
      
      function addGroupItem(name) {
         var newGroup = doc.groupItems.add();
         newGroup.name = name;
      }

      function makeListGroups(array) {
         for (var i = 0; i < array.length; ++i) {
            addGroupItem(array[i]);
         }
      };

      makeListGroups(groupNameArr);


   } catch(e) {
      alert(e)
   }

})();
