# Self guided and potentially novice reminders of extendscript syntax and practice
A project conceived to make my life easier in certain moments and harder in others

## TODO
* syntax highlighting for jsxinc  
* build the xml function suite, xml to AoA, xml to template obj
* test symlinks for .jsxinc files -- this works
* learn basic xpath expressions



### USING .jsxinc
.jsxinc is a C style linking method that .jsx supports. It gives us a way to modularize our components.

``` javascript

    #include "/Absolute/Path/To_Your/script.jsxinc"
```
It's worth noting, this appends the given script to your calling script at run time. 


### IIFE
"immediately invoked function expression", it's sole purpose is to avoid polluting the global scope when we are tossing variables around.  
This pattern has poor interaction with the .jsxinc feature, if the point of the script file is to provide utility functions used elsewhere 
then don't include inside an IIFE. It will prevent your main script from accessing the functions. 

``` javascript
    (function() {})();
```

### Identifying Objects and Their Hierarchy
* InDesign  
Use documentation!   
[InDesign API](https://www.indesignjs.de/extendscriptAPI/indesign-latest/#about.html) 
``` javascript
var obj = target_obj.collection[0];
var name = obj.constructor.name
var prototype_name = obj.isPrototypeOf()
```
  
* Illustrator

### HOW TO
* __access tables__  
Use the tables suite API  
Tables are text boxes, so must be targeted as text object first  
Text frame -> Tables[x] collection -> Table.contents
``` jsp

      var tbl = doc.selection[0];
      alert(tbl.contents.constructor.name)
      alert(tbl.tables[0].contents)
```
Use .bodyRowCount property to target the number of data rows on the template tables  
* __target rows and cells__  
Every level of the table is it's own object, will have to access the nested properties
```
      var input_tbl = target_table.tables[0];
      alert(input_tbl.bodyRowCount)
      alert(input_tbl.rows[0].cells.length)
```
We just need to loop through the data and set the contents of each cell in the target table.  
Each level is a "collection", or an AoO (array of objects)  
Targeting the specific cells of a table with XML is the next challenge:  
Sooo. The cell object does not support XML tagging. That sucks.  
There appears to be two different approaches we could take.  
    1. Script the tables into the story editor.  
    2. Forget having the bidirectional link, write a script that reads the tables and updates the xml accordingly.  
Personally, I think having the linking is too good to pass up. It is the bridge to a lot of automation that is desired. 

* __target a specific page__  
pages[] and pageItem  
spreads and allPageItems  
Key differences, spreads can target the pasteboard while pages only targets what's on the page.  
Since there is no itemByName method for allPageItems, it may be faster to simply create multiple component pages.  

* __making pages__  
Use the pages.add() method  
``` javascript

    doc.pages.add(LocationOptions.AT_END, last_master);
    alert(new_page.id);
```

* __duplicate__  
couldn't get .paste() working, duplicate works fine when passing an object reference from another function. 

* __use this flavor of REGEX__  
consider the [documentation](https://www.indesignjs.de/extendscriptAPI/indesign-latest/#RegExp.html)  
also consider [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions)  
There is overlap but neither doc is completely accurate for this version of ECMAscript. MDN is more reliable, since it shows the date a feature was added.  
__Known Methods__  
1. Replace
1. Match
1. Regex()
