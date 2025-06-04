# This is a markdown header
- list
- list 2
- list 3
## A smaller header
- list 4
- list 5
- list 6

### Action Items Example
1. [x] Figure out adding plugins to nvim config
2. [ ] Write notes on using markdown
3. [ ] Write .jsx testing battery

### References Example
[Markdown Syntax](https://www.markdownguide.org/basic-syntax/)

[How to Use Markdown Preview](https://github.com/iamcco/markdown-preview.nvim)

### Using Paragraphs
This is a paragraph. 
This is a line below the first, done incorrectly.  
This is a line below the first, done correctly. Add 2 spaces and a return at EoL.  
**This is BOLD Text**  
__This is also BOLD Text__  
*This is italicized Text*  
_This is also italicized Text_  
***Both at once, for important things?***  
___Again, both at once___  

### Using Block Quotes

> This is a block quote.  
> 
> This is inside the previous block quote

> This is a new block quote

### Using Ordered Lists
1. First Item
2. Second Item
3. Third Item  
---
This is a paragraph breaking the lists apart  
1. another ordered list
1. line 2
1. line 3, showing the markdown doesn't need sequential numbers
---
This is how unordered lists work
* Item 1
* Item 2
* Item 3 
---
It is possible to nest unordered and ordered lists
1. item 1
1. item 2
1. items 3
    * lettuce
    * tomato
    * veggie burger
1. item 4

### Using Code Blocks
use a tab or four spaces  -- this is legacy **MD**  
Javascript:

    function helloWorld(msg) {
        console.log(`Hello World!\n${msg}`)
    }
    
This is the latest syntax
```
    ``` Javascript
    given code... with syntax highlighting!
    ```
```
example:

``` javascript
console.log("Hello World");
const msg = "something something UX design";
console.log(`Hellow World\n${msg}`);
```


### Using Images
This is how to link an image inside **MD**  

```
    ![Alt text here](./path/to/image.gif)
```
---
Working Example: 

![Gradient, yellow to black, made with imagemagick](./gradient_range2.png)


### Using Links
It is similar to how other links are made  

    Have you ever heard of [Google?](https://google.com)  
Renders to:  
Have you ever heard of [Google?](https://google.com)  

---
### Extended Syntax  
Everything you need to get running and writing etc in __MD__ is given above. However, there are flavors of __MD__ that implement various features. Different applications for using __MD__ will implement this extended syntax in different ways.  


All of the extended syntax will come directly from the __MD__ documentation:  
[MARKDOWN DOC](https://www.markdownguide.org/extended-syntax/)



