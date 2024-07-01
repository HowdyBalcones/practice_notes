// How can we tag groups and do something according to the tag
// Labels, exporting, data merge?, variables?

(function() {

        var doc = app.activeDocument;
        var typeArr = [];
    // search functions
    try {
        // push onto itemArr
        function addText(textItem) {
           typeArr.push(textItem);
        };
        // recursive search for groups and group contents
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
        // search the document for groups and text
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

        // need to create something similar to loop group/page, but for objects
        // also need a better way to display them. UI ? 

        function inspectObjArr(array) {
            loopPage(doc);
            var propertiesArr = [];
            for (var i = 0; i < array.length; ++i) {
                var obj = array[i];
                for (var key in obj) {
                       try {
                            if (obj.hasOwnProperty(key)) {
                                propertiesArr.push(key + " -- " + obj[key]);
                            } else if (key instanceof Object) {
                                
                            }
                    } catch(e) { 
                        if (key.enumerable === false) {
                             propertiesArr.push(key + " is not enumerable");
                            }
                    };
                }
            };
                // alert(array[i].typename);
                // alert(propertiesArr.join("\n"));
                return propertiesArr;
        };
        function addTextBox(array) {
            var newText = doc.textFrames.add();
            newText.geometricBounds = [200, -200];
            newText.contents = array.join("\n")
            newText.columns = 2;
            alert("New text box with content: " + newText.characters[1]);
        }
        // inspectObjArr(typeArr);
        addTextBox(inspectObjArr(typeArr));
    } catch(e) {
        alert("Location: Variable Declaration - " + e)
    };

})();