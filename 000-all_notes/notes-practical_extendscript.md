# Self guided and potentially novice reminders of extendscript syntax and practice
A project conceived to make my life easier in certain moments and harder in others

## TODO
* fixed the xml bug today, error was in the xml map object. Wasn't trimming strings. silly. 
* syntax highlighting for jsxinc  
* learn basic xpath expressions
* levenshtein distance and a well made dictionary for referencing tokens against
* work with alex on the general groups, the exact sign names, conditions when a sign is unique vs when it's a copy
do something like a venn diagram, go through a contract line by line and drop the names into a bucket


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
Consider using a module object pattern when exporting, will also help with debugging. 

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
How to override master page items:  
``` js
    master_page_item.override(current_page);
    master_page_item.detach();
    break;
```
How to duplicate an item, be it a page or pageItem  
```
    var spotting_page = current_page.duplicate(LocationOptions.AFTER, current_page); 
```

* __duplicate__  
couldn't get .paste() working, duplicate works fine when passing an object reference from another function. 

* __use this flavor of REGEX__  
consider the [documentation](https://www.indesignjs.de/extendscriptAPI/indesign-latest/#RegExp.html)  
also consider [MDN Documentation](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_expressions)  
There is overlap but neither doc is completely accurate for this version of ECMAscript. MDN is more reliable, since it shows the date a feature was added.  
__Known Methods__  
 Replace  
 Match  
 Regex() 

* __Working with Text Frames__  
[Documentation](https://www.indesignjs.de/extendscriptAPI/indesign-latest/#TextFrame.html#d1e528640__d1e531105)  
You have to target the .contents value of the frame to manipulate the text  
Regex can be used, there are also builtin api methods like GREP

## Understanding the Data -> Template -> Book Pipeline  
The general approach to creating automation is as follows:  
1. Collect and normalize relevant company data  
1. Import that data to a template that contains components that are designed to be iterable   
1. Use a library of scripting tools to arrange those components into a form that production ready, or close to  

The components that actually make this all happen are listed here:  
1. contract db import, test export contract -- these two scripts filter the raw contracts and test the output for error  
1. xml export async, unique sign list export -- the parsing utilities, currently writes to XML format for importing into indesign  
1. the FRC-series of scripts contains modules of extendscript compatible Javascript. It handles anything that is directly related to the adobe api.  

The contract filters are used as CLI utilities. They work by calling node, the script, the destination of output, and the input file list.  
The XML utilities are the same, but the writing of the program is a bit more organized, as I learn a lot from project to project.  
The FRC-series scripts are extendscript, so are not compatible with node and most javascript modernizations. They are run within the adobe application directly, you can also script a tool to run scripts rather easily, and there are plugins for this.  

Where to solve problems:  
If at all possible, handle any complex or data related tasks outside of the extendscript interface. It is lacking most of the tools that have made javascript ubiquitous in the modern era.  
Things we use Node and modern JS to solve:  
* Normalizing data, writing to XLSX format  
* Parsing data formats, TXT, CSV, JSON, XML, etc
* Managing file level tasks where possible  
* Organizing, applying logic to, data and file structure  
* There are various tools and libraries that could be leveraged to create documents outside of the extendscript interface. For complexities sake, we have chosen to stay in that ecosystem. Rather than wrangling many APIs and libraries in the pursuit of the task, using a single more complex tool lowers the mental overhead and reduces potential conflicts between libraries. 

When extendscript is required, it means that using the adobe suite is mandatory for one reason or another. Ideally we are solving tasks in the Adobe suite that would otherwise be accomplished "by hand".  
* Taking data and placing it into assets
* organizing assets according to data  
* automating layout and variations in asset types  
* creating links between assets and data, TBD how that happens  
* document automation of various types, currently focusing on sign package documents but this could cover a larger scope. In a perfect world, the scripting library could write to many of the forms and documents Fource repeatedly makes by hand.  

What is the place of Bash in the pipeline?  
We have a partially organized server backend that has a lot of problems. Many of these problems are solvable technically speaking, but the inertia within the company that has built on top of expectations of the server will prevent these problems from being solved.  
Bash fills this role rather nicely, it has safe and performant utilities that can be scripted to accomplish all the tasks at hand.  
What it is used for, strictly:  
* finding files of a given type across the entire server directory  
* copying and updating files in just the data repositories used for the scripting project. 
* searching through specific areas of the server  
* could be used to distribute copies of the latest script build  
* is used to maintain the github repo for sure  
* grepping through the scripts to understand wtf I was thinking when I wrote something  

Obviously it could be used for a lot more, sysadmins with functional frontal lobes have automated some extremely complex tasks with a battery of shell scripts, to the point where they can leave for greener pastures and the backend will keep functioning. (more or less).  

