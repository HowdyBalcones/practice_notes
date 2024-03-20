// we are making a report writing program. 
// - split the page into fifths separated by a black line, 1.5pt stroke -- should these be "cells"? 
// 	+ the top/bottom of the line and the sides of the artboard function as a cell atm
// - place images evenly into each section of the page -- how to place the image in each section
// - place upcs evenly into each section of the page -- same problem as above 
// - place text from a formatted block report into each section -- read from prodLog into text box variables
// 	+ we really need an array of text boxes that each contain individual product specs
// - make sure each section has information only for the given product
// - export to ingest

// need something to calculate the page into fifths and pass them as variables into the line generator


#include "/Applications/Adobe Illustrator 2024/Presets.localized/en_US/Scripts/get-IllParam.jsx"

var doc = app.activeDocument;

var sourceName = app.activeDocument.name;
var savePath = "/Volumes/Graphics/Select III/003_Product_Images/000-Ingest/";
var saveFile = new File(savePath + sourceName);

var reportDirectory = readParameterFile();
var targetReport = "/reportLog.txt"

// getting artboard dimensions

var artboard = app.activeDocument.artboards[0];
var abBounds = artboard.artBoardRect;

String.prototype.trim = function () {
	return this.replace(/^\s+|\s+$/g, '');
}

function makeSections(abBounds) 
{
	var left = abBounds[0];
	var top = abBounds[1];
	var right = abBounds[2];
	var bottom = abBounds[3];
	var sectionHeight = -158.4;
	

	var line1 = doc.pathItems.add();
	line1.stroked = false;
	line1.setEntirePath([[0, 0], [right, 0]]);

	var line2 = doc.pathItems.add();
	line2.stroked = false;
	line2.setEntirePath([[left,bottom],[right,bottom]]);

	var line3 = doc.pathItems.add();
	line3.stroked = true;
	line3.setEntirePath([[left, sectionHeight], [right, sectionHeight]]);

	var line4 = doc.pathItems.add();
	line4.stroked = true;
	line4.setEntirePath([[left, sectionHeight*2], [right, sectionHeight*2]]);

	var line5 = doc.pathItems.add();
	line5.stroked = true;
	line5.setEntirePath([[left, sectionHeight*3], [right, sectionHeight*3]]);

	var line6 = doc.pathItems.add();
	line6.stroked = true;
	line6.setEntirePath([[left, sectionHeight*4], [right, sectionHeight*4]]);

//	alert("Top:" + top + "\nBottom:" + bottom);

}

function decodePath(reportDirectory)
{
	var decodedPath = reportDirectory.replace(/\n/g, '');
	return decodedPath;
}

// find the report based on the temp file that's adjusted by the bash script that runs this whole mess
// then output the contents of the report to whatever.
function getReportText()
{
	// just a path to the reportLog.txt
	var targetReportPath = decodePath(reportDirectory) + targetReport;
	// this should be the file
	var reportLog = new File(targetReportPath);
	if (reportLog.open("r")) {
		var targetReportContents = reportLog.read();
		reportLog.close();
		return targetReportContents;
	} else {
		alert("Failed to open prodLog in working directory, may be missing.")
		return null;
	}

}

function spaceReportText() 
{
	var groups = [];
	var tempGroup = [];
	var targetReportPath = decodePath(reportDirectory) + targetReport;

	// this just reads the reportLog into a variable and trims spaces. 
	// consider turning into a callback. 
	if (reportLog.open("r")) {
		var targetReportContents = reportLog.read();
		reportLog.close();
		var lines = targetReportContents.split('\n');
	}

	// this is what tokenizes each paragraph from the reportLog
	for (var i = 0; i < lines.length; ++i) {
		if (lines[i].trim() === '' && tempGroup.length > 0) {
			groups.push(tempGroup);
			tempGroup = [];
			continue;
		}
		if (tempGroup.length < 4) {
			tempGroup.push(lines[i]);
		}
		if (tempGroup.length === 4 || i === lines.length - 1) {
			groups.push(tempGroup);
			tempGroup = [];
		}
	}
	return groups;
}

function placeReportText(groups)
{
	var reportText = doc.textFrames.add();
	
	reportText.contents = groups;
}

// MAIN
// makeSections(artboard.artboardRect);
// placeReportText();
placeReportText(getReportText(reportDirectory));
