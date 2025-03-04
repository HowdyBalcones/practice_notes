//FindChangeGlyph.jsx
//An InCopy JavaScript
//
//Demonstrates the find glyph and change glyph features.
main();
function main(){
	mySetup();
	mySnippet();
	myTeardown();
}
function mySetup(){
	//Create an example document.
	var myDocument = app.documents.add();
	var myStory = myDocument.stories.item(0);
	var myString = "This is an example paragraph containing a specific glyph: \u25A0.\rThis is a paragraph containing a specific glyph:\u25A0.\rThis is another paragraph containing a specific glyph:\u25A0.";
	myStory.contents = myString;
}
function mySnippet(){
	//<fragment>
	//Clear glyph search preferences.
	app.findGlyphPreferences = NothingEnum.nothing;
	app.changeGlyphPreferences = NothingEnum.nothing;
	var myDocument = app.documents.item(0);
	//You must provide a font that is used in the document for the
	//appliedFont property of the findGlyphPreferences object.
	app.findGlyphPreferences.appliedFont = app.fonts.item("Minion Pro	Regular");
	//Provide the glyph ID, not the glyph Unicode value.
	app.findGlyphPreferences.glyphID = 500;
	//The appliedFont of the changeGlyphPreferences object can be
	//any font available to the application.
	app.changeGlyphPreferences.appliedFont = app.fonts.item("Times New Roman	Regular");
	app.changeGlyphPreferences.glyphID = 374;
	myDocument.changeGlyph();
	//Clear glyph search preferences.
	app.findGlyphPreferences = NothingEnum.nothing;
	app.changeGlyphPreferences = NothingEnum.nothing;
	//</fragment>
}
function myTeardown(){
}