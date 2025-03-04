//ListOpenDocs.jsx
//An InDesign Server JavaScript

var result = "";
if(app.documents.length > 0) 
{
    for(var i = 0; i < app.documents.length; i++){
	    result = result + "\n[" + i + "] = " + app.documents.item(i).name;
    }
    result = result + "\n";
} else {
    result = "No documents are open.";
}

result;
