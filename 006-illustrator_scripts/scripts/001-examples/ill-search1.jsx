(function () {
   try {
      var thisDoc = app.activeDocument;
      var testText = 'dog, cat, bird, plane, Dog, hog';
      var typeArr = [];
   } catch(e) {
      alert('Location: Initializers ' + e)
   }

   try {
      function findIllText(targetContainer) {
         
      };
   } catch(e) {
      alert("Location: findIllText " + e);
   }

   try {
      
      function addText(textItem) {
         typeArr.push(textItem);
      };

      function loopGroup(group) {
         for (var i = 0; i < group.groupItems.length; ++i) {
           item = group.pageItems[i];
            if (item.typename === "TextFrame") {
               addText(item.contents);
            } else if (item.typename === "GroupItem") {
               loopGroup(item);
            } 
         }
      };
      
      function loopPage(container) {
         for (var i = 0; i < container.pageItems.length; ++i) {
            var item = container.pageItems[i];
            if (item.typename === "TextFrame") {
               addText(item.contents);
            } else if (item.typename === "GroupItem") {
               loopGroup(item)
            }
         }
      };
      
   } catch(e) {
      alert("Location: search functions " + e);
   }

   try {
      function matchIllText(targetContainer) {
         var regex = new RegExp(/TESTING/gi);
         loopPage(thisDoc);
         var docText = typeArr.join(' ');
         var matches = docText.match(regex);
         if (matches === null) {
            alert("There were no matches!")
         } else {
            alert(matches.length);
         }
            alert(typeArr.length);
      }
   } catch(e) {
      alert("Location matchIllText " + e);
   }

   try {
     matchIllText(thisDoc);
     // searchIllGroups(thisDoc);
   } catch(e) {
      alert("Location: function calls " + e);
   }

})();
