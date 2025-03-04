//PackageAssignment.jsx
//An InCopy JavaScript
//
//Shows how to create an InCopy package file.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
}
function mySnippet(){
	myCreateAssignmentsPackage();
	
}
function myTeardown(){
}
function myCreateAssignmentsPackage()
{
	var myDocument = app.documents.item(0);
	var myAssignement = myDocument.assignments.item(0);
	if(myAssignement.packaged==false)
	{
			var myFile= new File("/c/b.icap");
			myAssignement.createPackage(myFile,PackageType.FORWARD_PACKAGE);
	}

}