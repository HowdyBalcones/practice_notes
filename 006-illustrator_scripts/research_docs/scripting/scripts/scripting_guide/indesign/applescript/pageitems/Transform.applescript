--Transform.applescript
--An InDesign AppleScript
--
--Shows how to use the transform method.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--<fragment>
		--Given a document "myDocumnent" with a text frame on page 1...
		set myTextFrame to text frame 1 of page 1 of myDocument
		set myString to "The page contains an example text frame." & return & return
		set myString to myString & "Watch as we apply a series of transformations." & return & return
		set myString to myString & "You  might have to drag the alert out" & return
		set myString to myString & "of the way to see the effect of the transformation."
		display dialog myString
		my myRotate(myTextFrame, center anchor, 45, false)
		display dialog "Rotated 45 degrees around center anchor."
		--Undo the transformation.
		tell myDocument to undo
		my myScale(myTextFrame, center anchor, 0.5, 0.5, false)
		display dialog "Scaled by 50 percent around center anchor."
		tell myDocument to undo
		my myTranslate(myTextFrame, center anchor, 72, 72, false)
		display dialog "Moved by 72 points in both directions."
		tell myDocument to undo
		my myShear(myTextFrame, center anchor, 15, false)
		display dialog "Sheared by 15 degrees around center anchor."
		tell myDocument to undo
		my myRotate(myTextFrame, {{92, 92}, top left anchor}, 45, true)
		display dialog "Rotated 45 degrees around ruler coordinate {92, 92}."
		tell myDocument to undo
		my myScale(myTextFrame, {{92, 92}, top left anchor}, 2, 2, true)
		display dialog "Scaled by 200 percent around  ruler coordinate [92, 92]."
		tell myDocument to undo
		--</fragment>
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		set when scaling of transform preferences to adjust scaling percentage
		set horizontal measurement units of view preferences of myDocument to points
		set vertical measurement units of view preferences of myDocument to points
		tell page 1 of myDocument
			--Create an example text frame.
			set myTextFrame to make text frame with properties {geometric bounds:{"72pt", "72pt", "288pt", "288pt"}, contents:placeholder text}
			tell myTextFrame to recompose
		end tell
	end tell
end mySetup
--<fragment>
on myRotate(myObject, myAnchor, myAngle, myUseRulerCoordinates)
	tell application "Adobe InDesign 2024"
		set myTransformationMatrix to make transformation matrix with properties {counterclockwise rotation angle:myAngle}
		transform myObject in pasteboard coordinates from myAnchor with matrix myTransformationMatrix considering ruler units myUseRulerCoordinates
	end tell
end myRotate
on myScale(myObject, myAnchor, myXScale, myYScale, myUseRulerCoordinates)
	tell application "Adobe InDesign 2024"
		set myTransformationMatrix to make transformation matrix with properties {horizontal scale factor:myXScale, vertical scale factor:myYScale}
		transform myObject in pasteboard coordinates from myAnchor with matrix myTransformationMatrix considering ruler units myUseRulerCoordinates
	end tell
end myScale
on myShear(myObject, myAnchor, myShearAngle, myUseRulerCoordinates)
	tell application "Adobe InDesign 2024"
		set myTransformationMatrix to make transformation matrix with properties {clockwise shear angle:myShearAngle}
		transform myObject in pasteboard coordinates from myAnchor with matrix myTransformationMatrix considering ruler units myUseRulerCoordinates
	end tell
end myShear
on myTranslate(myObject, myAnchor, myXTranslate, myYTranslate)
	tell application "Adobe InDesign 2024"
		set myTransformationMatrix to make transformation matrix with properties {horizontal translation:myXTranslate, vertical translation:myYTranslate}
		transform myObject in pasteboard coordinates from myAnchor with matrix myTransformationMatrix
	end tell
end myTranslate
--</fragment>
on myTeardown()
end myTeardown
