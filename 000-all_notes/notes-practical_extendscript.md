# Self guided and potentially novice reminders of extendscript syntax and practice
A project conceived to make my life easier in certain moments and harder in others

## TODO
* syntax highlighting for jsxinc  
* build the xml function suite, xml to AoA, xml to template obj
* test symlinks for .jsxinc files
* learn basic xpath expressions



### USING .jsxinc
.jsxinc is a C style linking method that .jsx supports. It gives us a way to modularize our components.

``` javascript

    #include "/Absolute/Path/To_Your/script.jsxinc"
```
It's worth noting, this appends the given script to your calling script at run time. 


### IIFE
"immediately invoked function expression", it's sole purpose is to avoid polluting the global scope when we are tossing variables around.

``` javascript
    (function() {})();
```

### Identifying Objects and Their Hierarchy
* InDesign  
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

* __target a specific page__  
pages[] and pageItem  
spreads and allPageItems  
Key differences, spreads can target the pasteboard while pages only targets what's on the page.  
Since there is no itemByName method for allPageItems, it may be faster to simply create multiple component pages.  

* __duplicate__  
couldn't get .paste() working, duplicate works fine when passing an object reference from another function. 

