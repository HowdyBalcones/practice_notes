// point of this script is to proof of concept targeting text elements
// inside of illustrator. 

// fix text find to account for groups, layers, masks (yay)
// uncomment all of the matching function to see if it still works


(function() {
try { 
    var thisDoc = app.activeDocument;
    var testText = 'dog, cat, bird, plane, Dog, hog';
    // setting target to a file 
    } catch(e) {
    alert('Location: initializers ' + e)
}
    
    // this makes an array of each top level text element in a target document
try {
    function findIllText(targetContainer) {
        // how to loop through GroupItem so text nested in a given 
        // number of groups is listed 

        var targetTextName = [];
        var targetTextContent = [];
        var combinedText = [];

        for (var i = 0; i < targetContainer.pageItems.length; ++i) {
        // some variable here that changes the target of the loop
        // to account for the group and mask hierarchy
        var item = targetContainer.pageItems[i];
            if (item.typename == "TextFrame") {
                targetTextName.push(item.name);
                targetTextContent.push(item.contents);
                combinedText.push("\n" + "Element Name: " + targetTextName[i] + "\n" + "Target Text Content: " + targetTextContent[i]);
        }
        alert(combinedText);
        // return combinedText;
    }
 }
} catch(e) {
    alert("Location findIllText: " + e)
}

try {
    function searchIllGroups(targetContainer) {
        textArr = [];
        typeArr = [];
        combinedArr = [];
        // for (var i = 0; i < targetContainer.length; ++i) {
        //     var item = targetContainer.pageItems[i];
        //     if (item === "GroupItem") {
        //         searchIllGroups(item);
        //         // textArr.push(item.contents);
        //     } else if (item.typename == "TextFrame") {
        //         textArr.push(item.contents);
        //     }
        // }
        // alert(textArr);
        // // return textArr;
        for (var i = 0; i < targetContainer.pageItems.length; ++i) {
            var item = targetContainer.pageItems[i];
            if (item.typename === "TextFrame") {
                typeArr.push(item.typename);
                textArr.push(item.contents);
            } else if (item.typename === "GroupItem") {
                searchIllGroups(item);
            } else {
               alert("No Groups or Text");
            }
        }
        alert(textArr);
    }
} catch(e) {
    alert("Location searchIllGroups: " + e)
}

try {
        function matchIllText(targetDoc) {
            // ideally the match would be user defined
            var regex = new RegExp(/avocado/gi);
            var docText = findIllText(targetDoc);
            // var docTextString = docText.toString();
            // for (var i = 0; i < docText.length; ++i) {
// 
            // }
            // var matches = docTextString.match(regex);
            // var matchesNumber = matches.length;
            alert(docText);
            // alert(matches + "\nNumber of Matches: " + matchesNumber);
        }; 

    // findIllText(thisDoc);
    // searchIllGroups(thisDoc);
  searchIllGroups(thisDoc);
} catch(e) {
    alert("Location matchIllText: " + e);
}
    // var regex = '/dog/i'
    // var re = new RegExp(/dog/gi);
    // var re2 = new RegExp(/playing/gi);
    // alternate - var re = new RegExp("/dog/", "gi")
    // var matches = testText.match(regex);
    // var tests = re.test(testText);
    // var matches = testText.match(re);
    // var fileMatches = pdfText.match(re2);
    // alert(pdfText);



})();