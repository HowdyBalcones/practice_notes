// use the debugger even though it's brutal
// examples below 

println(app.activeDocs);
var startDoc = app.openDoc("testDoc.pdf", this);
app.alert( "startDoc", 3);
// using println for testing
var monitors = app.monitors;
console.println("\nThere are " + monitors.length + " monitors connected to this system.");
var l = app.printColorProfiles.length
for (var i = 0; i < l; i++)
    console.println("(" + (i+1) + ") " + "nuts" + app.printColorProfiles[i]);

// you must highlight every line to execute in the debugger
// you can also write programs and run them separately, which is more sane. 
