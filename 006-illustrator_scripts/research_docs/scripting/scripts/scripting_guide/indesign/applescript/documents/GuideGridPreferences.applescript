--GuideGridPreferences.applescript
--An InDesign AppleScript
--
--Shows how to set preferences for guides and grids.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
		tell view preferences of myDocument
			set horizontal measurement units to inches
			set vertical measurement units to inches
		end tell
	end tell
end mySetup
on mySnippet()
	--Shows how to set preferences for guides and grids.
	tell application "Adobe InDesign 2024"
		set myDocument to document 1
		--![Snapping to guides and grids.]
		--Given a document "myDocument"...
		--Guide Preferences
		tell guide preferences of myDocument
			set guides in back to true
			set guides locked to false
			set guides shown to true
			set guides snapto to true
			--Set the ruler guide color by UI color name:
			set ruler guides color to cute teal
			--Set the ruler guide color using a list of RGB values:
			set ruler guides color to {0, 198, 192}
			--Set the ruler view threshold (magnification at which guides appear).
			set ruler guides view threshold to 50
		end tell
		set myBaselineStart to top of page of baseline grid relative option
		set myBaselineStart to top of margin of baseline grid relative option
		--Grid Preferences
		tell grid preferences of myDocument
			--Baseline Grid
			set baseline start to "2in"
			set baseline grid relative option to myBaselineStart
			--Set the ruler guide color by UI color name:
			set baseline color to light blue
			--Set the ruler guide color using a list of RGB values:
			set baseline color to [0, 198, 192]
			set baseline division to "22pt"
			set baseline grid shown to true
			set baseline view threshold to 75
			--Document Grid
			set document grid snapto to true
			set document grid shown to false
			--Set the grid color by UI color name:
			set grid color to charcoal
			--Set the grid color using a list of RGB values:
			set grid color to {192, 192, 192}
			--Set spacing of the grid based on current measurement units (inches).
			set horizontal gridline division to 1
			set horizontal grid subdivision to 4
			set vertical gridline division to 1
			set vertical grid subdivision to 4
		end tell
		--![Snapping to guides and grids.]
	end tell
end mySnippet
on myTeardown()
end myTeardown
