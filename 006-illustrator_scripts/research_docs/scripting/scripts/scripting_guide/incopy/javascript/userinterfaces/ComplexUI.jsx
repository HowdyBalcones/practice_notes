//ComplexUI.jsx
//An InCopy CS3 JavaScript
// 
//Shows how to create a more complex dialog box.
var myDialog = app.dialogs.add({name:"ComplexUI", canCancel:true});
with(myDialog){
	var mySwatchNames = app.swatches.everyItem().name;
	//Add a dialog column.
	with(dialogColumns.add()){
		//Create a border panel.
		with(borderPanels.add()){
			with(dialogColumns.add()){
				with(dialogRows.add()){
					//The following line shows how to set a property 
					//as you create an object.
					staticTexts.add({staticLabel:"Message:"});
					//The following line shows how to set multiple 
					//properties as you create an object.
					var myTextEditField = textEditboxes.add({editContents:"Hello World!", minWidth:180});
				}
			}
		}
		//Create another border panel.
		with(borderPanels.add()){
			with(dialogColumns.add()){
				with(dialogRows.add()){
					staticTexts.add({staticLabel:"Point Size:"});
					//Create a number entry field. Note that this field uses editValue
					//rather than editText (as a textEditBox would).
					var myPointSizeField = measurementEditboxes.add({editValue:72, editUnits:MeasurementUnits.points});
				}
			}
		}
		//Create another border panel.
		with(borderPanels.add()){
			with(dialogColumns.add()){
				with(dialogRows.add()){
					staticTexts.add({staticLabel:"Paragraph Alignment:"});
					var myRadioButtonGroup = radiobuttonGroups.add();
					with(myRadioButtonGroup){
						radiobuttonControls.add({staticLabel:"Left", checkedState:true});
						radiobuttonControls.add({staticLabel:"Center"});
						radiobuttonControls.add({staticLabel:"Right"});
					}
				}
			}
		}
		//Create another border panel.
		with(borderPanels.add()){
			with(dialogColumns.add()){
				with(dialogRows.add()){
					staticTexts.add({staticLabel:"Text Color:"});
				}
				var mySwatchDropdown = dropdowns.add({stringList:mySwatchNames, selectedIndex:4});
			}
		}
	}
}
//Display the dialog box.
if(myDialog.show() == true){
	var myParagraphAlignment, myString, myPointSize, myVerticalJustification;
	//If the user didn’t click the Cancel button,
	//then get the values back from the dialog box.	
	//Get the example text from the text edit field.
	var myString = myTextEditField.editContents 
	//Get the point size from the point size field.
	var myPointSize = myPointSizeField.editValue; 
	//Get the paragraph alignment setting from the radiobutton group.
	if(myRadioButtonGroup.selectedButton == 0){
		myParagraphAlignment = Justification.leftAlign;
	}
	else if(myRadioButtonGroup.selectedButton == 1){
		myParagraphAlignment = Justification.centerAlign;
	}
	else{
		myParagraphAlignment = Justification.rightAlign;
	}
	var mySwatchName = mySwatchNames[mySwatchDropdown.selectedIndex];
	//Remove the dialog box from memory.
	myDialog.destroy();
	//Now create the document and apply the properties to the text.
	var myDocument = app.documents.add();
	with(myDocument.stories.item(0)){
		//Set the contents of the story to the string you entered 
		//in the dialog box.
		contents = myString;
		//Set the alignment of the paragraph.
		texts.item(0).justification = myParagraphAlignment;
		//Set the point size of the text.
		texts.item(0).pointSize = myPointSize;
		//Set the fill color of the text.
		texts.item(0).fillColor = myDocument.swatches.item(mySwatchName);
	}
}
else{
	myDialog.destroy()
}