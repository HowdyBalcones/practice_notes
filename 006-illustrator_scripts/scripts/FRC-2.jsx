(function() {
      
   try {
      var doc = app.activeDocument;
   } catch(e) {
      alert(e.name + ": " + e.message + "\nNo active document");
   }

   function dollarSign() {
      alert($.fileName);
   }
   // removes leading whitespace, 1 or more spaces with 1 space
   function trimAndCollapse(string) {
      return string.replace(/^ +| +$/g, "");
   }

   function normalizeNewLines(data) {
      return data.replace(/\r\n/g, "\n").replace(/\r/g, "\n");
   }
   
   function readFile(filePath) {
      var file = new File(filePath);
      if (file.open('r')) {
         var fileContent = file.read();
         file.close();
         return fileContent;
      } else {
         alert("Failed to open the file.");
      }
   }

   // This makes an empty group, cycles through the current selection, for each item in selection it adds it to the new group. 
   function makeGroup() {
      if (app.activeDocument.selection.length > 0) {
      var newGroup = doc.groupItems.add()
         for(var i = 0; i < selection.length; ++i) {
            //alert(selection[i].fillColor)
            var selectedItem = doc.selection[i];
            selectedItem.move(newGroup, ElementPlacement.INSIDE);
            newGroup.name = "Testing-" + [i];
         }   
      } else {
         alert("No selection")
      }
 }

   // this will rename group item in the selection array
function renameGroup(newName) {
      var currentSelection = app.activeDocument.selection;
      if (currentSelection.length > 0) {
            for (var i = 0; i < currentSelection.length; ++i) {
               var selectedItem = currentSelection[i];
               if (selectedItem.typename === "GroupItem")
               selectedItem.name = newName + "-" + i;
            }
      }  else {
         alert("No selection")
      }
   }
   
   function giveCmyk(c,m,y,k) {
      var newCMYKColor = new CMYKColor();
      var cmykValues = [c,m,y,k];
      var colorProperties = ['cyan','magenta','yellow','black'];
      for (var i = 0; i < colorProperties.length; ++i) {
         newCMYKColor[colorProperties[i]] = cmykValues[i];
      }
      return newCMYKColor;
   }

   function giveRgb(r,g,b) {
      var newRGBColor = new RGBColor();
      var rgbValues = [r,g,b];
      var colorProperties = ['red', 'green', 'blue'];
      for (var i = 0; i < colorProperties.length; ++i) {
         newRGBColor[colorProperties[i]] = rgbValues[i];
      }
      return newRGBColor;
   }

   function giveLab(l,a,b)  {
      var newLabColor = new LabColor();
      var labValues = [l,a,b];
      var colorProperties = ['l','a','b'];
      for (var i = 0; i < colorProperties.length; ++i) {
         newLabColor[colorProperties[i]] = labValues[i];
      }
      return newLabColor;
   }

   function giveGray(saturation) {
      var newGrayColor = new GrayColor();
      newGrayColor.gray = saturation;
      return newGrayColor;
   }

   function checkCmyk(target1, target2) {
      var t1Cyan = target1.cyan.toFixed(2);
      var t1Magenta = target1.magenta.toFixed(2);
      var t1Yellow = target1.yellow.toFixed(2);
      var t1Black = target1.black.toFixed(2);

      var t2Cyan = target2.cyan.toFixed(2);
      var t2Magenta = target2.magenta.toFixed(2);
      var t2Yellow = target2.yellow.toFixed(2);
      var t2Black = target2.black.toFixed(2);
      
      if (t1Cyan === t2Cyan &&
          t1Magenta === t2Magenta &&
          t1Yellow === t2Yellow &&
          t1Black === t2Black) {
      return true;
      } else {
      return false;
      }
   }

   // all objects of a certain color in a selection are grouped together
   function groupByColor(color) {
      var currentSelection = doc.selection;
      var targetColor = giveCmyk(100,50,25,0);      
      var newGroup = doc.groupItems.add();
      for (var i = 0; i < currentSelection.length; ++i) {
         var item = currentSelection[i];
         if (checkCmyk(item.fillColor, targetColor)) {
            item.move(newGroup, ElementPlacement.INSIDE);
            newGroup.name = "TESTING SORT-" + i;
         }
      }
   }

   function setColor(list, colorVal) {
      var len = list.length;
      var colSpace = doc.documentColorSpace;
      for (var i = 0; i < len; ++i) {
         var item = list[i];
         var colorType = item.fillColor;
         if (item.fillColor) {
            var newColor;
            switch(colSpace) {
               case DocumentColorSpace.RGB:
                  newColor = giveRgb(colorVal[0], colorVal[1], colorVal[2]);
                  break;
               case DocumentColorSpace.CMYK:
                  newColor = giveCmyk(colorVal[0], colorVal[1], colorVal[2], colorVal[3]);
                  break;
            }
            item.fillColor = newColor;
         }  else if (item.typename === "GroupItem" || item.typename === "CompoundPathItem") {
               setColor(item.pageItems, colorVal);
         } else {
            alert("No fill color value for " + item.name + "\n");
         }
      }     
   }

   function setRandomRgb(item) {
      var ran1 = giveRandomInt(0, 255);
      var ran2 = giveRandomInt(0, 255); 
      var ran3 = giveRandomInt(0, 255); 
      var newRgb = new RGBColor(); 
      newRgb.red = ran1;
      newRgb.green = ran2;
      newRgb.blue = ran3;
      item.fillColor = newRgb;
   }

   function renameAndGroupByColor() {
      var currentSelection = doc.selection;
      var colorsList = [];

      for (var i = 0; i < currentSelection.length; ++i) {
         var item = currentSelection[i];
         var cRound = item.fillColor.cyan.toFixed(1);
         var mRound = item.fillColor.magenta.toFixed(1);
         var yRound = item.fillColor.yellow.toFixed(1);
         var bRound = item.fillColor.black.toFixed(1);
         
         var colorExists = false;
         var targetGroup = null;

         for (var j = 0; j < colorsList.length; ++j) {
            if (checkCmyk(item.fillColor, colorsList[j].color)) {
               colorExists = true;
               targetGroup = colorsList[j].group;
               break;
            }
         }
         if (!colorExists) {
            var newGroup = doc.groupItems.add();
            newGroup.name = cRound + "-" + mRound + "-" + yRound + "-" + bRound;
            colorsList.push({
               color: item.fillColor,
               group: newGroup
            });
            
            targetGroup = newGroup;
         }
         item.move(targetGroup, ElementPlacement.PLACEATEND);
      }
   }
   
   function makeShape(shape, count) {
      // something to make a shape based on the name passed to function and returns a number of that shape
   }

   function gimmeType() {
      var currentSelection = doc.selection;
      var itemList = [];
      var output = "";
      for (var i = 0; i < selection.length; ++i) {
         itemList.push(currentSelection[i].typename);
      }
      
      for (var j = 0; j < itemList.length; ++j) {
         output += itemList[j] + ", ";
      }
      alert(output);
   }

   function parser(data) {
      var rows = [];
      var currentRow = [];
      var currentCell = '';

      var insideQuote = false;
      var length = data.length;

      for (var i = 0; i < length; ++i) {
         var character = data[i];
         var nextChar = data[i + 1];
         
         if (character === '"' && (!insideQuote || nextChar === '"')) {
            // if the current character is a quote, and if not already inside a quote or the next char is another quote
            if (insideQuote && nextChar === '"') {
               // if inside a quote and the next char is a quote, escape the quote by adding a quote
               // then skip the added quote
               currentCell += '"';
               ++i;
            } else {
               // toggle quote state - note, this doesn't mean turn to false, it means turn to opposite
               // so that's a good pattern ! Handles state of quotes with one line. 
               insideQuote = !insideQuote;
            }
         } else if (character === ',' && !insideQuote) {
            // if not inside a quote, count comma as cell separator and push the cell onto currentRow
            currentRow.push(trimAndCollapse(currentCell));
            currentCell = '';
         } else if (character === '\n' && !insideQuote) { 
            // if newline, push the cell onto currentRow, push currentRow onto row, clear currentCell/Row
            currentRow.push(trimAndCollapse(currentCell));
            rows.push(currentRow);
            currentRow = [];
            currentCell = '';
         } else {
            // append char to currentCell string
            currentCell += character;
         }
      }

      if (currentCell || currentRow.length > 0) {
         currentRow.push(trimAndCollapse(currentCell));
         rows.push(currentRow);
      }
      return rows;
   } 

   function label() {
      var labelName = prompt('Please enter your label name: ', 'Label will be applied to selected group.');
      var currentSelection = doc.selection;

      for (var i = 0; i < currentSelection.length; ++i) {
         var item = currentSelection[i];
         if (item.typename === "GroupItem") {
           // apply the label to the items name 
            item.name = labelName;
         }
      }
   }

   function labelFromList(list) {
      // this needs to take the contract and create groups based on line items from each section

   }

   function makeProductionFiles(list) {
      // this needs to make files named as - job_id-job_name-section_id-revision

   }

   function workingListMake() {
     // need to address problem of two lists existing in the document, or just lock/unlock it.  
     try { 
      var report = doc.textFrames.getByName("countReport-00");
      if (report) {
         report.remove();
      }
     } catch(e) {
         $.writeln("Report not detected, writing new report..." + e.message);
     }

      var groupCounter = {};
      var newText = doc.textFrames.add();
      newText.name = "countReport-00"
      newText.contents = "GROUPNAME-GROUPCOUNT";
     
      
      for (var i = 0; i < doc.groupItems.length; ++i) {
         var item = doc.groupItems[i];
         // here we need to check if the group name exists already
         if (groupCounter[item.name]) {
            groupCounter[item.name]++;
         } else {
            groupCounter[item.name] = 1;
         }
      }
      for (var groupName in groupCounter) {
         newText.contents += "\n" + groupName + " - " + "Count: " + groupCounter[groupName];
      }
      newText.position = [0,0];
   }

   function testingColor() {
      var testColor = giveCmyk(100,50,25,0);
      var testColor2 = giveCmyk(100,49,25,0);
      checkCmyk(testColor, testColor2);
   }
   
   function testingPrompt() {
      var name = prompt("Please enter sign type name: ", "IE: LCES-Door Vinyl");
      alert("Your sign name is: " + name)
   }
   
   function simpleTest(item) {
      if (item) {
         alert(item.name)
      } else {
         alert("No item name.")
      }
   }

   function simpleTestEach(list) {
      var len = list.length;
      for (var i = 0; i < len; ++i) {
         var item = list[i];
         alert(item.typename);
      }
   }

   function loopView(selection, func) {
      // goal is to pass this function a selection, it will go through each item and center the camera on it, prompting for each
   if (selection.length > 0) {
      for (var i = 0; i < selection.length; ++i) {
         var item = selection[i];
            var bounds = item.visibleBounds;
            var centerX = (bounds[0] + bounds[2]) / 2;
            var centerY = (bounds[1] + bounds[3]) / 2;
            var activeView = doc.activeView;
            activeView.centerPoint = [centerX, centerY];
            activeView.zoom = .75;
            var answer = confirm("Apply to this object?");
         if (answer) {
            func(item);
         } else {
            ++i;
         }
      }
     } else {
       alert("No items in selection.")
     }
   }

   function rasterPlanGrey(items) {
      var raster_options = {
         resolution: 100,
         transparency: false,
      }
      for (var i = 0; i < items.length; ++i) {
         var item = items[i];
         var rasterItem = doc.rasterize(item, item.geometricBounds, raster_options);
      }
      $.gc();
   }

   function processInChunks(items, chunkSize, delay) {
      for (var i = 0; i < items.length; i += chunkSize) {
         var chunk = items.slice(i, i + chunkSize);
         rasterPlanGrey(chunk);
         $.sleep(delay);
      }
   }

   function applyRandomly(list, callback) {
      var len = list.length;
      var randomUpBound = giveRandomInt(1,len);
      for (var i = 0; i < len; ++i) {
         var item = list[i];
         if (item.typename === "GroupItem" || item.typename === "CompoundItem") {
            applyRandomly(item.pageItems, callback);
         } else {
            var ran = giveRandomInt(1,randomUpBound-1);
            var randomItem = list[ran];
            for (var j = 0; j < ran; ++j) {
               callback(randomItem);
            }
         }
      }
   }

   function giveRandomInt(min, max) {
      min = Math.ceil(min);
      max = Math.floor(max);
      return Math.floor(Math.random() * (max - min + 1)) + min;
   }

   function testObjColor() {
      var item = doc.selection[0];
      var colSpace = doc.documentColorSpace;
      alert(item.typename);
      // alert(item.fillColor instanceof CMYKColor);
      // alert(colSpace == "DocumentColorSpace.CMYK");
   }

   function typeSizeIncrement(item) {
      item = doc.selection[0];
      if (item.typename === "TextFrame") {
         var charCount = item.textRange.characters.length;
         var size = 100;
         for (var i = 0; i < charCount; ++i, size *= 1.2) {
            item.textRange.characters[i].characterAttributes.verticalScale = size;
            item.textRange.characters[i].characterAttributes.horizontalScale = size;
         }
      } else {
         alert("Not a TextFrame!")
      }
   } 

   function typeTest() {
      alert(doc.selection[0].typename);
   }


// ---- Function Testing ----
// testingPrompt();
// dollarSign();
// makeGroup();
// renameGroup("RenamingTest");
// groupByColor("Red");
// renameAndGroupByColor();
// gimmeType();
// workingListMake();
// testingColor();
//   label();
   // makeList(testCsv);
   // alert(readFile(testFilePath));
// loopView(doc.selection, simpleTest);
// rasterPlanGrey();
// processInChunks(selection, 2, 400);
 // testObjColor();
//  setColor(doc.selection,[50,100,75,0]);
// applyRandomly(doc.selection, setRandomRgb)
// simpleTestEach(doc.selection);
typeSizeIncrement();
  })();
