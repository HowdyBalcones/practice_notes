//TextImportPreferences.jsx
//An InCopy JavaScript
//
//Sets the text import filter preferences.
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
	with(app.textImportPreferences){
		//Options for characterSet:
		//TextImportCharacterSet.ansi
		//TextImportCharacterSet.chineseBig5
		//TextImportCharacterSet.gb18030
		//TextImportCharacterSet.gb2312
		//TextImportCharacterSet.ksc5601
		//TextImportCharacterSet.macintoshCE
		//TextImportCharacterSet.macintoshCyrillic
		//TextImportCharacterSet.macintoshGreek
		//TextImportCharacterSet.macintoshTurkish
		//TextImportCharacterSet.recommendShiftJIS83pv
		//TextImportCharacterSet.shiftJIS90ms
		//TextImportCharacterSet.shiftJIS90pv
		//TextImportCharacterSet.utf8
		//TextImportCharacterSet.utf16
		//TextImportCharacterSet.windowsBaltic
		//TextImportCharacterSet.windowsCE
		//TextImportCharacterSet.windowsCyrillic
		//TextImportCharacterSet.windowsEE
		//TextImportCharacterSet.windowsGreek
		//TextImportCharacterSet.windowsTurkish
		characterSet = TextImportCharacterSet.utf16;
		convertSpacesIntoTabs = true;
		spacesIntoTabsCount = 3;
		//The dictionary property can take any of the following
		//language names (as strings):
		//Bulgarian
		//Catalan
		//Croatian
		//Czech
		//Danish
		//Dutch
		//English:Canadian
		//English:UK
		//English:USA
		//English:USA Legal
		//English:USA Medical
		//Estonian
		//Finnish
		//French
		//French:Canadian
		//German:Reformed
		//German:Swiss
		//German:Traditional
		//Greek
		//Hungarian
		//Italian
		//Latvian
		//Lithuanian
		//Neutral
		//Norwegian:Bokmal
		//Norwegian:Nynorsk
		//Polish
		//Portuguese
		//Portuguese:Brazilian
		//Romanian
		//Russian
		//Slovak
		//Slovenian
		//Spanish:Castilian
		//Swedish
		//Turkish
		dictionary = "English: USA";
		//platform options:
		//ImportPlatform.macintosh
		//ImportPlatform.pc
		platform = ImportPlatform.macintosh;
		stripReturnsBetweenLines = true;
		stripReturnsBetweenParagraphs = true;
		useTypographersQuotes = true;
	}
	//</fragment>
}
function myTeardown(){
}
