#targetengine "session"
//ProgressBar.jsx
//An InCopy CS3 JavaScript
//
//Creates a progress bar in the "session" engine that can be called
//from other scripts.
var myProgressPanel;
var myMaximumValue = 300;
var myProgressBarWidth = 300;
var myIncrement = myMaximumValue/myProgressBarWidth;
myCreateProgressPanel(myMaximumValue, myProgressBarWidth);
function myCreateProgressPanel(myMaximumValue, myProgressBarWidth){
	myProgressPanel = new Window('window', 'Progress');
	with(myProgressPanel){
		myProgressPanel.myProgressBar = add('progressbar', [12, 12, myProgressBarWidth, 24], 0, myMaximumValue);
	}
}