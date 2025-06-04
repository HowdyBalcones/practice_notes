# Get going for Docusaurus
[Starting Documentation](https://docusaurus.io/docs/installation) | [Further Reading](https://docusaurus.io/docs/docs-introduction)

---

## Setting up the skeleton  
```
    npx create-docusaurus@latest my-website classic
```
There are additional tags here that can be added [at your discretion](https://docusaurus.io/docs/api/misc/create-docusaurus)

## Using the directories
```
my-website
├── blog
│   ├── 2019-05-28-hola.md
│   ├── 2019-05-29-hello-world.md
│   └── 2020-05-30-welcome.md
├── docs
│   ├── doc1.md
│   ├── doc2.md
│   ├── doc3.md
│   └── mdx.md
├── src
│   ├── css
│   │   └── custom.css
│   └── pages
│       ├── styles.module.css
│       └── index.js
├── static
│   └── img
├── docusaurus.config.js
├── package.json
├── README.md
├── sidebars.js
└── yarn.lock
```

* __Blog:__  
    This is a feature that probably won't get used in our case. Has some unique functionality.  
    Possible to disable. 
* __Docs:__  | [docs doc]()  
    Where most of our files will likely end up. Docs enables sidebar by default.  
    You can nest directories and set up search, tags, and general navigation through this directory.  
* __Src:__  | [src doc](https://docusaurus.io/docs/creating-pages#add-a-markdown-page)  
    CSS will be stored here, this can be altered for custom styling and interactivity.  
    Pages are also included here. These are meant for standalone pages, do not include a sidebar like docs.
* __.config.js__ | [config doc](https://docusaurus.io/docs/configuration)  
    This is the general configuration file used to set up the docusaurus site. 
        
    
## This is live

