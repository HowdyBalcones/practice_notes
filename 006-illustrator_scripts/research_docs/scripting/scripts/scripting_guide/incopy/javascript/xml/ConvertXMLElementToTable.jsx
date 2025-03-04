//ConvertXMLElementToTable.jsx
//An InCopy JavaScript
//
//Shows how to convert an XML element to a table.
main();
function main(){
    mySetup();
    mySnippet();
    myTeardown();
}
function mySetup(){
}
function mySnippet(){
    //<fragment>
    var myDocument = app.documents.add();
    var myPage = myDocument.pages.item(0);
    //Create a series of XML tags.
    var myRowTag = myDocument.xmlTags.add("row");
    var myCellTag = myDocument.xmlTags.add("cell");
    var myTableTag = myDocument.xmlTags.add("table");
    //Add XML elements.
    var myRootXMLElement = myDocument.xmlElements.item(0);
    with(myRootXMLElement){
        var myTableXMLElement = xmlElements.add(myTableTag);
        with(myTableXMLElement){
            for(var myRowCounter = 1;myRowCounter < 7;myRowCounter++){
                with(xmlElements.add(myRowTag)){
                    myString = "Row " + myRowCounter;
                    for(var myCellCounter = 1; myCellCounter < 5; myCellCounter++){
                        with(xmlElements.add(myCellTag)){
                            contents = myString + ":Cell " + myCellCounter;
                        }
                    }
                }
            }
        }
    }
    var myTable = myTableXMLElement.convertElementToTable(myRowTag, myCellTag);
    var myStory = myDocument.stories.item(0);
    myStory.placeXML(myRootXMLElement);
    //</fragment>
}
function myTeardown(){
}