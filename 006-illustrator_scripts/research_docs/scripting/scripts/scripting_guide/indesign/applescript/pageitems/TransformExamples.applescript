--TransformExamples.applescript
--An InDesign AppleScript
--
--A brief demonstration of the transform method.
--
--The transform method has the following parameters:
--
--in (pasteboard coordinates, parent coordinates, 
--spread coordinates, or inner coordinates)
--The coordinate space to use for the transformation.
--
--from (as an array of two numbers, an anchor point,
--or a an array of two numbers and an anchor point)
--The center of transformation.
--
--matrix (Transformation Matrix):
--Specify the matrix used to transform the object.
--
--replacing current (Boolean):
--If true, replace the current transformation values of the object
--with the values of the transformation matrix.
--
--considering ruler units (Boolean)
--If true, use the current ruler units and zero point location
--when transforming the object.
--
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySnippet()
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Transform examples.]
		--Given a document "myDocument"...
		set when scaling of transform preferences to adjust scaling percentage
		--Rotate a rectangle "myRectangle" around its center point.
		set myRotateMatrix to make transformation matrix with properties {counterclockwise rotation angle:27}
		--Scale a rectangle "myRectangle" around its center point.
		set myScaleMatrix to make transformation matrix with properties {horizontal scale factor:0.5, vertical scale factor:0.5}
		--Shear a rectangle "myRectangle" around its center point.
		set myShearMatrix to make transformation matrix with properties {clockwise shear angle:30}
		tell page 1 of myDocument
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 288}}
			transform myRectangle in pasteboard coordinates from center anchor with matrix myRotateMatrix
			--Create another rectangle.
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 288}}
			--Transform the rectangle.
			transform myRectangle in pasteboard coordinates from center anchor with matrix myScaleMatrix
			--Create another rectangle.
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 288}}
			--Transform the rectangle.
			transform myRectangle in pasteboard coordinates from center anchor with matrix myShearMatrix
			--Scale a rectangle "myRectangle" around a specified ruler point ({72, 72})
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 288}}
			transform myRectangle in pasteboard coordinates from {{72, 72}, center anchor} with matrix myRotateMatrix with considering ruler units
			--Rotate a rectangle "myRectangle" around a specified ruler point ({72, 72})
			set myRectangle to make rectangle with properties {geometric bounds:{72, 72, 144, 288}}
			transform myRectangle in pasteboard coordinates from {{72, 72}, center anchor} with matrix myScaleMatrix with considering ruler units
		end tell
		--![Transform examples.]
	end tell
end mySnippet
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to points
			set vertical measurement units to points
		end tell
	end tell
end mySetup
on myTeardown()
end myTeardown
