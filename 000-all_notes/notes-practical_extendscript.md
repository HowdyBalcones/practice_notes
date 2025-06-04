# Self guided and potentially novice reminders of extendscript syntax and practice

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

### HOW TO
* __access tables__  
Use the tables suite API  
Tables are text boxes, so must be targeted as text object first
* __target a specific page__  
pages[] and pageItem  
spreads and allPageItems  
Key differences, spreads can target the pasteboard while pages only targets what's on the page.  
Since there is no itemByName method for allPageItems, it may be faster to simply create multiple component pages.

