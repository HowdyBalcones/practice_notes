--AnimationEncyclopedia.applescript
--An InDesign AppleScript
--
--Author: Brenda Burden
--Creates a 6-page sample doc demonstrating the InDesign Animation feature
-- PAGE ONE - Sample of Animation Properties 
-- PAGE TWO - Sample of all Animation Events
-- PAGE THREE - Sample of Additional Animation Properties and Settings, including Duration, Play count, Loop, Speed and Origin
-- PAGE FOUR - Sample of Animate To, Animate From, To Current location
-- PAGE FIVE - Sample of creating Timing Groups, setting Delays, and looping a Timing Group
-- PAGE SIX - Complex A-B-C-D animation that can be created only through scripting (cannot be created in the UI)
tell application "Adobe InDesign 2024"
	set myFont to font "Myriad Pro"
	set myDocument to make document
	tell myDocument
		my mySetUnits(inches)
		set ruler origin of view preferences to page origin
		set blending space of transparency preferences to RGB
		set facing pages of document preferences to false
		set page width of document preferences to 11.111
		set page height of document preferences to 8.333
		set myTextColor to color "Black" of myDocument
		--Create a series of colors.
		my myMakeColor("Red", RGB, process, {255, 0, 0})
		my myMakeColor("Green", RGB, process, {0, 255, 0})
		my myMakeColor("Blue", RGB, process, {0, 0, 255})
		my myMakeColor("Purple", RGB, process, {200, 0, 255})
		my myMakeColor("Light Gray", RGB, process, {200, 200, 200})
		--
		--Page One
		--
		--Create Background
		set myGraphicFrame to make rectangle with properties {geometric bounds:{"0in", "0in", "8.333in", "11.111in"}}
		set fill color of myGraphicFrame to "Light Gray"
		--Create headline
		set myTextFrame to my myMakeTextFrame(page 1, {0.25, 0, 1, 11.111}, "Animation Properties" & return, "Myriad Pro", 28, center align, false)
		--Create subheadings
		my myMakeTextFrame(page 1, {1.25, 1, 1.625, 10.5}, "Motion Path", "Myriad Pro", 18, left align, true)
		my myMakeTextFrame(page 1, {2.25, 1, 2.625, 10.5}, "Rotation", "Myriad Pro", 18, left align, true)
		my myMakeTextFrame(page 1, {3.25, 1, 3.625, 10.5}, "Opacity", "Myriad Pro", 18, left align, true)
		my myMakeTextFrame(page 1, {4.25, 1, 4.625, 10.5}, "Scale", "Myriad Pro", 18, left align, true)
		my myMakeTextFrame(page 1, {5.25, 1, 5.625, 10.5}, "Combination", "Myriad Pro", 18, left align, true)
		my myMakeTextFrame(page 1, {6.25, 1, 6.625, 10.5}, "Color Fade", "Myriad Pro", 18, left align, true)
		my myMakeTextFrame(page 1, {7.25, 1, 7.625, 10.5}, "Motion Path with Curve", "Myriad Pro", 18, left align, true)
		--Create a motion path.
		my mySetUnits(points)
		set myMotionPath to {{{{0, 0}, {0, 0}, {0, 0}}, {{565, 0}, {565, 0}, {565, 0}}}, true}
		my mySetUnits(inches)
		--Create rectangles to animate
		set myRectangle1 to my myMakeRectangle(page 1, {1.625, 1, 2, 2}, "Motion Path Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle1
			set motion path points to myMotionPath
		end tell
		set myRectangle2 to my myMakeRectangle(page 1, {2.625, 1, 3, 2}, "Rotation Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle2
			set motion path points to myMotionPath
			set rotation array to {{0, 0}, {23, 270}}
		end tell
		set myRectangle3 to my myMakeRectangle(page 1, {3.625, 1, 4, 2}, "Opacity Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle3
			set motion path points to myMotionPath
			set opacity array to {{0, 100}, {23, 10}}
		end tell
		set myRectangle4 to my myMakeRectangle(page 1, {4.625, 1, 5, 2}, "Scale Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle4
			set motion path points to myMotionPath
			set scale x array to {{0, 100}, {23, 20}}
			set scale y array to {{0, 100}, {23, 20}}
		end tell
		set myRectangle5 to my myMakeRectangle(page 1, {5.625, 1, 6, 2}, "Combination Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle5
			set motion path points to myMotionPath
			set scale x array to {{0, 100}, {23, 20}}
			set scale y array to {{0, 100}, {23, 20}}
			set rotation array to {{0, 0}, {23, -270}}
			set opacity array to {{0, 100}, {23, 25}}
		end tell
		--The next two rectangles are in the same location; this is intentional.
		set myRectangle6 to my myMakeRectangle(page 1, {6.625, 1, 7, 2}, "Color Fade Rectangle Purple", "Blue", "None", 0)
		tell animation settings of myRectangle6
			set motion path points to myMotionPath
			set opacity array to {{0, 0}, {23, 100}}
		end tell
		set myRectangle7 to my myMakeRectangle(page 1, {6.625, 1, 7, 2}, "Color Fade Rectangle Blue", "Purple", "None", 0)
		tell animation settings of myRectangle7
			set motion path points to myMotionPath
			set opacity array to {{0, 100}, {23, 50}}
		end tell
		my mySetUnits(points)
		set myMotionPath to {{{{0, 0}, {0, 0}, {0, 0}}, {{565, 0}, {565, -150}, {565, 0}}}, true}
		my mySetUnits(inches)
		set myRectangle8 to my myMakeRectangle(page 1, {7.625, 1, 8, 2}, "Motion Path with Curve Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle8
			set motion path points to myMotionPath
		end tell
		--Timing settings appear on the spread, not the page.
		set myPageOneTimingSettings to timing settings of spread 1
		tell myPageOneTimingSettings
			--Remove the On Page Load timing list.  Default Animation Event is On Page Load.
			delete timing list 1
			--Add an On Page Click timing list.
			set p1TimingOnPageClickList to make timing list with properties {trigger event:on page click}
			--Add Animations as separate On Page Click Timing Groups
			tell p1TimingOnPageClickList
				set p1timingGroup1 to make timing group with properties {dynamic target:myRectangle1, delay seconds:0}
				set p1timingGroup2 to make timing group with properties {dynamic target:myRectangle2, delay seconds:0}
				set p1timingGroup3 to make timing group with properties {dynamic target:myRectangle3, delay seconds:0}
				set p1timingGroup4 to make timing group with properties {dynamic target:myRectangle4, delay seconds:0}
				set p1timingGroup5 to make timing group with properties {dynamic target:myRectangle5, delay seconds:0}
				set p1timingGroup6 to make timing group with properties {dynamic target:myRectangle6, delay seconds:0}
				--Link rectangle 6 and 7
				tell p1timingGroup6
					make timing target with properties {dynamic target:myRectangle7, delay seconds:0}
				end tell
				set p1timingGroup7 to make timing group with properties {dynamic target:myRectangle8, delay seconds:0}
			end tell
		end tell
	end tell
	--
	--Page 2
	--
	--Motion presets are stored in the application context
	set myMotionPreset to Motion Preset "twirl"
	tell myDocument
		--Add a page.
		make page
		--Define a motion preset.
		--Add a background rectangle.
		my myMakeRectangle(page 2, {0, 0, 8.333, 11.111}, "", "Light Gray", "None", 0)
		set myTextFrame to my myMakeTextFrame(page 2, {0.25, 0, 1, 11.111}, "Animation Events" & return, "Myriad Pro", 28, center align, false)
		--On Page Load section.
		my myMakeTextFrame(page 2, {1.25, 1, 1.625, 10.5}, "On Page Load", "Myriad Pro", 18, left align, true)
		set myRectangle1P2 to my myMakeRectangle(page 2, {1.625, 1, 2, 2}, "On Page Load Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle1P2
			set preset to myMotionPreset
		end tell
		--On Page Click section.
		my myMakeTextFrame(page 2, {2.25, 1, 2.625, 10.5}, "On Page Click", "Myriad Pro", 18, left align, true)
		set myRectangle2P2 to my myMakeRectangle(page 2, {2.625, 1, 3, 2}, "On Page Click Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle2P2
			set preset to myMotionPreset
		end tell
		--On Self Click section.
		my myMakeTextFrame(page 2, {3.25, 1, 3.625, 10.5}, "On Click (Self)", "Myriad Pro", 18, left align, true)
		set myRectangle3P2 to my myMakeRectangle(page 2, {3.625, 1, 4, 2}, "On Self Click Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle3P2
			set preset to myMotionPreset
		end tell
		--On Self Rollover section.
		my myMakeTextFrame(page 2, {4.25, 1, 4.625, 10.5}, "On Roll Over (Self)", "Myriad Pro", 18, left align, true)
		set myRectangle4P2 to my myMakeRectangle(page 2, {4.625, 1, 5, 2}, "On Self Rollover Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle4P2
			set preset to myMotionPreset
		end tell
		--On Button Click section.
		my myMakeTextFrame(page 2, {5.25, 1, 5.625, 10.5}, "On Button Event (On Click)", "Myriad Pro", 18, left align, true)
		set myRectangle5p2 to my myMakeRectangle(page 2, {5.625, 1, 6, 2}, "Button Click Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle5p2
			set preset to myMotionPreset
		end tell
		tell page 2
			set myButton to make button with properties {geometric bounds:{5.625, 3, 6, 4}, fill color:"Green", stroke color:"Green", name:"Play Animation Button"}
		end tell
		tell myButton
			make animation behavior with properties {behavior event:mouse down, enable behavior:true, animated page item:myRectangle5p2, auto reverse on roll off:false, operation:play}
		end tell
		--On MSO State Load section
		my myMakeTextFrame(page 2, {6.25, 1, 6.625, 10.5}, "On State Load of Multi-State Object", "Myriad Pro", 18, left align, true)
		tell page 2
			set myMSO to make multi state object with properties {name:"My Simple MSO", geometric bounds:{6.625, 1, 7, 2}, initially hidden:true}
		end tell
		tell myMSO
			--Add a third state.
			make state
			tell state 1
				set name to "Top State"
				set myRectangleMSO to my myMakeRectangle(state 1 of myMSO, {6.625, 1, 7, 2}, "Top State Rectangle", "Purple", "None", 0)
				tell animation settings of myRectangleMSO
					set preset to myMotionPreset
				end tell
				tell animation settings of myRectangleMSO
					set preset to myMotionPreset
				end tell
			end tell
			tell state 2
				set name to "Second State"
				set myOvalMSO to my myMakeRectangle(state 2 of myMSO, {6.625, 1, 7, 2}, "Second State Oval", "Purple", "None", 0)
				tell myOvalMSO
					convert shape given convert to oval
				end tell
				tell animation settings of myOvalMSO
					set preset to myMotionPreset
				end tell
			end tell
			tell state 3
				set name to "Third State"
				set myPolygonMSO to my myMakeRectangle(state 3 of myMSO, {6.625, 1, 7, 2}, "Third State Polygon", "Purple", "None", 0)
				tell myPolygonMSO
					convert shape given convert to polygon
				end tell
				tell animation settings of myPolygonMSO
					set preset to myMotionPreset
				end tell
			end tell
		end tell
		--Create the button that controls the state of the MSO.
		tell page 2
			set myPlayMSOButton to make button with properties {geometric bounds:{6.625, 3, 7, 4}, fill color:"Green", stroke color:"Green", name:"Go to Next State of MSO Button"}
		end tell
		--Link the button to the MSO.
		tell myPlayMSOButton
			set myMSOBehavior2 to make goto next state behavior with properties {associated multi state object:myMSO, loops to next or previous:true, behavior event:mouse down}
		end tell
		--Page 2 timing section
		set myPageTwoTimingSettings to timing settings of spread 2
		tell myPageTwoTimingSettings
			--Remove the On Page Load timing list.  Default Animation Event is On Page Load.
			delete timing list 1
			--Create On Page Load
			set mySecondPageLoadTimingList to make timing list with properties {trigger event:on page load}
			tell mySecondPageLoadTimingList
				set secondSpreadTimingG1 to make timing group with properties {dynamic target:myRectangle1P2, delay seconds:0}
			end tell
			--Create On Page Click
			set mySecondPageClickTimingList to make timing list with properties {trigger event:on page click}
			tell mySecondPageClickTimingList
				set secondSpreadTimingG2 to make timing group with properties {dynamic target:myRectangle2P2, delay seconds:0}
			end tell
			--Create Self Click
			tell timing settings of myRectangle3P2
				set myRectangle3P2TimingList to make timing list with properties {trigger event:on self click}
			end tell
			--Create Self Roll Over
			tell timing settings of myRectangle4P2
				set myRectangle4P2TimingList to make timing list with properties {trigger event:on self rollover}
			end tell
		end tell
		--
		--Page 3
		--
		make page
		--Add a background rectangle.
		my myMakeRectangle(page 3, {0, 0, 8.333, 11.111}, "", "Light Gray", "None", 0)
		--Add a headline.
		set myTextFrame to my myMakeTextFrame(page 3, {0.25, 0, 1, 11.111}, "Additional Animation Properties and Settings" & return, "Myriad Pro", 28, center align, false)
		--Create text labels.
		set myTextFrame1P3 to my myMakeTextFrame(page 3, {1.25, 1, 1.625, 4.5}, "Duration: 2 seconds", "Myriad Pro", 18, left align, true)
		set myTextFrame2P3 to my myMakeTextFrame(page 3, {2.25, 1, 2.625, 4.5}, "Duration: .5 seconds", "Myriad Pro", 18, left align, true)
		set myTextFrame3P3 to my myMakeTextFrame(page 3, {3.25, 1, 3.625, 4.5}, "Speed: Ease In", "Myriad Pro", 18, left align, true)
		set myTextFrame4P3 to my myMakeTextFrame(page 3, {4.25, 1, 4.625, 4.5}, "Speed: Ease Out", "Myriad Pro", 18, left align, true)
		set myTextFrame5P3 to my myMakeTextFrame(page 3, {5.25, 1, 5.625, 4.5}, "Speed: Ease In and Out", "Myriad Pro", 18, left align, true)
		set myTextFrame6P3 to my myMakeTextFrame(page 3, {6.25, 1, 6.625, 4.5}, "Play Twice", "Myriad Pro", 18, left align, true)
		set myTextFrame7P3 to my myMakeTextFrame(page 3, {7.25, 1, 7.625, 4.5}, "Loop", "Myriad Pro", 18, left align, true)
		set myTextFrame8P3 to my myMakeTextFrame(page 3, {1.25, 5, 1.625, 10.5}, "Hide Until Animated", "Myriad Pro", 18, left align, true)
		set myTextFrame9P3 to my myMakeTextFrame(page 3, {2.25, 5, 2.625, 10.5}, "Hide After Animating", "Myriad Pro", 18, left align, true)
		set myTextFrame10P3 to my myMakeTextFrame(page 3, {3.25, 5, 3.625, 10.5}, "Origin Upper Left Corner", "Myriad Pro", 18, left align, true)
		set myTextFrame11P3 to my myMakeTextFrame(page 3, {4.25, 5, 4.625, 10.5}, "Origin Right Center", "Myriad Pro", 18, left align, true)
		--Create rectangles.
		--Create 2 second duration
		set myRectangle1P3 to my myMakeRectangle(page 3, {1.625, 1, 2, 2}, "2-Second Duration Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle1P3
			set duration to 2
			set rotation array to {{0, 0}, {47, 180}}
		end tell
		--Create .5 second duration
		set myRectangle2P3 to my myMakeRectangle(page 3, {2.625, 1, 3, 2}, ".5-Second Duration Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle2P3
			set duration to 0.5
			set rotation array to {{0, 0}, {11, 180}}
		end tell
		--Create ease in
		set myRectangle3P3 to my myMakeRectangle(page 3, {3.625, 1, 4, 2}, "Ease In Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle3P3
			set duration to 2
			set rotation array to {{0, 0}, {47, 180}}
			set ease type to ease in
		end tell
		--Create ease out
		set myRectangle4P3 to my myMakeRectangle(page 3, {4.625, 1, 5, 2}, "Ease Out Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle4P3
			set duration to 2
			set rotation array to {{0, 0}, {47, 180}}
			set ease type to ease out
		end tell
		--Create ease in and out
		set myRectangle5P3 to my myMakeRectangle(page 3, {5.625, 1, 6, 2}, "Ease In and Out Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle5P3
			set duration to 2
			set rotation array to {{0, 0}, {47, 180}}
			set ease type to ease in out
		end tell
		--Create plays twice
		set myRectangle6P3 to my myMakeRectangle(page 3, {6.625, 1, 7, 2}, "Play Twice Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle6P3
			set duration to 2
			set plays to 2
			set rotation array to {{0, 0}, {47, 180}}
		end tell
		--Create loop
		set myRectangle7P3 to my myMakeRectangle(page 3, {7.625, 1, 8, 2}, "Loop Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle7P3
			set duration to 2
			set plays loop to true
			set rotation array to {{0, 0}, {47, 180}}
		end tell
		--Create hide until animated
		set myRectangle8P3 to my myMakeRectangle(page 3, {1.625, 5, 2, 6}, "Hide Until Animated Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle8P3
			set duration to 2
			set initially hidden to true
			set hidden after to false
			set rotation array to {{0, 0}, {47, 180}}
		end tell
		--Create hide after animating
		set myRectangle9P3 to my myMakeRectangle(page 3, {2.625, 5, 3, 6}, "Hide After Animating Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle9P3
			set duration to 2
			set initially hidden to false
			set hidden after to true
			set rotation array to {{0, 0}, {47, 180}}
		end tell
		--Origin top left
		set myRectangle10P3 to my myMakeRectangle(page 3, {3.625, 5, 4, 6}, "Origin Upper Left Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle10P3
			set duration to 2
			set transform offsets to {0, 0}
			set rotation array to {{0, 0}, {47, 180}}
		end tell
		--Origin right center
		set myRectangle11P3 to my myMakeRectangle(page 3, {4.625, 5, 5, 6}, "Origin Right Center Rectangle", "Purple", "None", 0)
		tell animation settings of myRectangle11P3
			set duration to 2
			set transform offsets to {1, 0.5}
			set rotation array to {{0, 0}, {47, 180}}
		end tell
	end tell
	--
	--Page 4
	--
	set myMoveRightGrowPreset to Motion Preset "move-right-grow"
	set myFlyInLeftPreset to Motion Preset "fly-in-left"
	tell myDocument
		make page
		--Add a background rectangle.
		my myMakeRectangle(page 4, {0, 0, 8.333, 11.111}, "", "Light Gray", "None", 0)
		--Add a headline.
		set myTextFrame to my myMakeTextFrame(page 4, {0.25, 0, 1, 11.111}, "Animate Options" & return, "Myriad Pro", 28, center align, false)
		--Create text labels.
		set myTextFrame1P4 to my myMakeTextFrame(page 4, {1.25, 1, 1.625, 10.5}, "Animate: From Current Appearance", "Myriad Pro", 18, left align, true)
		set myTextFrame2P4 to my myMakeTextFrame(page 4, {2.25, 1, 2.625, 10.5}, "Animate: To Current Appearance", "Myriad Pro", 18, left align, true)
		set myTextFrame3P4 to my myMakeTextFrame(page 4, {3.25, 1, 3.625, 10.5}, "Animate: To Current Location", "Myriad Pro", 18, left align, true)
		--Create rectangles.
		--Create from current appearance animation.
		set myRectangle1P4 to my myMakeRectangle(page 4, {1.625, 1, 2, 2}, "Animate From Current Appearance", "Purple", "None", 0)
		tell animation settings of myRectangle1P4
			set design option to from current appearance
			set preset to myMoveRightGrowPreset
		end tell
		--Create to current appearance animation.
		set myRectangle2P4 to my myMakeRectangle(page 4, {2.625, 1, 3, 2}, "Animate To Current Appearance", "Purple", "None", 0)
		tell animation settings of myRectangle2P4
			set preset to myMoveRightGrowPreset
			set design option to to current appearance
		end tell
		--Create 
		set myRectangle3P4 to my myMakeRectangle(page 4, {3.625, 1, 4, 2}, "Animate To Current Location", "Purple", "None", 0)
		tell animation settings of myRectangle3P4
			set design option to to current location
			set preset to myFlyInLeftPreset
		end tell
		--
		--Page 5
		--
		make page
		--Add a background rectangle.
		my myMakeRectangle(page 5, {0, 0, 8.333, 11.111}, "Background Rectangle", "Light Gray", "None", 0)
		--Add a headline.
		set myTextFrame to my myMakeTextFrame(page 5, {0.25, 0, 1, 11.111}, "Timing Panel - Timing Groups and Delays" & return, "Myriad Pro", 28, center align, false)
		--Create text labels.
		set myTextFrame1P5 to my myMakeTextFrame(page 5, {1.25, 1, 1.625, 10.5}, "A-1", "Myriad Pro", 18, left align, true)
		set myTextFrame2P5 to my myMakeTextFrame(page 5, {2.25, 1, 2.625, 10.5}, "A-2", "Myriad Pro", 18, left align, true)
		set myTextFrame3P5 to my myMakeTextFrame(page 5, {3.25, 1, 3.625, 10.5}, "A-3", "Myriad Pro", 18, left align, true)
		set myTextFrame4P5 to my myMakeTextFrame(page 5, {4.25, 1, 4.625, 10.5}, "A-4", "Myriad Pro", 18, left align, true)
		set myTextFrame5P5 to my myMakeTextFrame(page 5, {5.25, 1, 5.625, 10.5}, "B-1 (Delay 1 Second)", "Myriad Pro", 18, left align, true)
		set myTextFrame6P5 to my myMakeTextFrame(page 5, {6.25, 1, 6.625, 10.5}, "B-2 (Delay 0.5 Seconds)", "Myriad Pro", 18, left align, true)
		set myTextFrame7P5 to my myMakeTextFrame(page 5, {7.25, 1, 7.625, 10.5}, "B-3 (Delay 1 Second)", "Myriad Pro", 18, left align, true)
		set myTextFrame8P5 to my myMakeTextFrame(page 5, {1.25, 5, 1.625, 10.5}, "C-1 (Delay 0.25 Seconds)", "Myriad Pro", 18, left align, true)
		set myTextFrame9P5 to my myMakeTextFrame(page 5, {2.25, 5, 2.625, 10.5}, "C-2 (Delay 0.25 Seconds)", "Myriad Pro", 18, left align, true)
		set myTextFrame10P5 to my myMakeTextFrame(page 5, {3.25, 5, 3.625, 10.5}, "C-3 (Delay 0.25 Seconds)", "Myriad Pro", 18, left align, true)
		set myTextFrame11P5 to my myMakeTextFrame(page 5, {4.25, 5, 4.625, 10.5}, "C-4 (Delay 0.25 Seconds)", "Myriad Pro", 18, left align, true)
		set myTextFrame12P5 to my myMakeTextFrame(page 5, {5.25, 5, 5.625, 10.5}, "C-5 (Delay 0.25 Seconds)", "Myriad Pro", 18, left align, true)
		--Create rectangles.
		--A section.
		set myRectangle1P5 to my myMakeRectangle(page 5, {1.625, 1, 2, 2}, "A-1", "Purple", "None", 0)
		tell animation settings of myRectangle1P5
			set preset to myMotionPreset
		end tell
		set myRectangle2P5 to my myMakeRectangle(page 5, {2.625, 1, 3, 2}, "A-2", "Purple", "None", 0)
		tell animation settings of myRectangle2P5
			set preset to myMotionPreset
		end tell
		set myRectangle3P5 to my myMakeRectangle(page 5, {3.625, 1, 4, 2}, "A-3", "Purple", "None", 0)
		tell animation settings of myRectangle3P5
			set preset to myMotionPreset
		end tell
		set myRectangle4P5 to my myMakeRectangle(page 5, {4.625, 1, 5, 2}, "A-4", "Purple", "None", 0)
		tell animation settings of myRectangle4P5
			set preset to myMotionPreset
		end tell
		--B section.
		set myRectangle5P5 to my myMakeRectangle(page 5, {5.625, 1, 6, 2}, "B-1", "Green", "None", 0)
		tell animation settings of myRectangle5P5
			set preset to myMotionPreset
		end tell
		set myRectangle6P5 to my myMakeRectangle(page 5, {6.625, 1, 7, 2}, "B-2", "Green", "None", 0)
		tell animation settings of myRectangle6P5
			set preset to myMotionPreset
		end tell
		set myRectangle7P5 to my myMakeRectangle(page 5, {7.625, 1, 8, 2}, "B-3", "Green", "None", 0)
		tell animation settings of myRectangle7P5
			set preset to myMotionPreset
		end tell
		--C section.
		set myRectangle8P5 to my myMakeRectangle(page 5, {1.625, 5, 2, 6}, "C-1", "Blue", "None", 0)
		tell animation settings of myRectangle8P5
			set preset to myMotionPreset
		end tell
		set myRectangle9P5 to my myMakeRectangle(page 5, {2.625, 5, 3, 6}, "C-2", "Blue", "None", 0)
		tell animation settings of myRectangle9P5
			set preset to myMotionPreset
		end tell
		set myRectangle10P5 to my myMakeRectangle(page 5, {3.625, 5, 4, 6}, "C-3", "Blue", "None", 0)
		tell animation settings of myRectangle10P5
			set preset to myMotionPreset
		end tell
		set myRectangle11P5 to my myMakeRectangle(page 5, {4.625, 5, 5, 6}, "C-4", "Blue", "None", 0)
		tell animation settings of myRectangle11P5
			set preset to myMotionPreset
		end tell
		set myRectangle12P5 to my myMakeRectangle(page 5, {5.625, 5, 6, 6}, "C-5", "Blue", "None", 0)
		tell animation settings of myRectangle12P5
			set preset to myMotionPreset
		end tell
		set spread5TimingSettings to timing settings of spread 5
		tell spread5TimingSettings
			delete timing list 1
			set myP5PageLoadTimingList to make timing list with properties {trigger event:on page load}
			tell myP5PageLoadTimingList
				set spread5TimingG1 to make timing group with properties {dynamic target:myRectangle1P5, delay seconds:0}
				tell spread5TimingG1
					make timing target with properties {dynamic target:myRectangle2P5, delay seconds:0}
					make timing target with properties {dynamic target:myRectangle3P5, delay seconds:0}
					make timing target with properties {dynamic target:myRectangle4P5, delay seconds:0}
				end tell
				set spread5TimingG2 to make timing group with properties {dynamic target:myRectangle5P5, delay seconds:1}
				tell spread5TimingG2
					make timing target with properties {dynamic target:myRectangle6P5, delay seconds:0.5}
					make timing target with properties {dynamic target:myRectangle7P5, delay seconds:1}
					set plays loop to true
				end tell
				set spread5TimingG3 to make timing group with properties {dynamic target:myRectangle8P5, delay seconds:0.25}
				tell spread5TimingG3
					make timing target with properties {dynamic target:myRectangle9P5, delay seconds:0.25}
					make timing target with properties {dynamic target:myRectangle10P5, delay seconds:0.25}
					make timing target with properties {dynamic target:myRectangle11P5, delay seconds:0.25}
					make timing target with properties {dynamic target:myRectangle12P5, delay seconds:0.25}
					set plays to 2
				end tell
			end tell
		end tell
		--
		--Page 6
		--
		make page
		--Add a background rectangle.
		my myMakeRectangle(page 6, {0, 0, 8.333, 11.111}, "Background Rectangle", "Light Gray", "None", 0)
		--Add a headline.
		set myTextFrame to my myMakeTextFrame(page 6, {0.25, 0, 1, 11.111}, "Scripted Animation with Multiple Property Changes" & return, "Myriad Pro", 28, center align, false)
		--Create text labels.
		set myTextFrame1P6 to my myMakeTextFrame(page 6, {1.25, 1, 1.625, 10.5}, "6-Second Animation with one or more property changes per second", "Myriad Pro", 18, left align, true)
		
		set myRectangle1P6 to my myMakeRectangle(page 6, {1.625, 1, 2, 2}, "Scripted Animation Rectangle", "Purple", "None", 0)
		--Set duration before adding keyframes when scripting animations
		tell animation settings of myRectangle1P6
			set duration to 6
			--Assumes 24 Frames Per Second (FPS)
			--23 = 1 second, 47 = 2 seconds, 71 = 3 seconds, 95 = 4 seconds, 119 = 5 seconds, 143 = 6 seconds
			--
			--Note that the animation here is created with motionPath, which allows for setting keyframes that correspond to points in the path
			my mySetUnits(points)
			set motion path to {{0, {{0, 0}, {0, 0}, {0, 0}}}, {23, {{200, 0}, {200, 0}, {200, 0}}}, {47, {{200, 200}, {200, 200}, {200, 200}}}, {119, {{0, 200}, {0, 200}, {0, 200}}}, {143, {{0, 0}, {0, 0}, {0, 0}}}}
			--Note that this animation allows setting multiple changes in opacity, scale and rotation that correspond 
			--to points in the motion path. This functionality is not available in the Animation panel shown in the user interface.
			set rotation array to {{0, 0}, {23, 180}, {47, 0}, {71, -180}, {95, 0}, {119, 180}, {143, -360}}
			set scale x array to {{0, 100.0}, {23, 200.0}, {47, 100.0}, {71, 300.0}, {95, 100.0}, {119, 200.0}, {143, 100.0}}
			set scale y array to {{0, 100.0}, {23, 0.0}, {47, 100.0}, {71, 0.0}, {95, 100.0}, {119, 300.0}, {143, 100.0}}
			set opacity array to {{0, 100.0}, {23, 0.0}, {47, 100.0}, {71, 0.0}, {95, 100.0}, {119, 0.0}, {143, 100.0}}
			set plays to 1
			set plays loop to false
			set ease type to no ease
			set transform offsets to {0.5, 0.5}
			set design option to from current appearance
			set initially hidden to false
			set hidden after to false
		end tell
	end tell
end tell
on mySetUnits(myUnits)
	tell application "Adobe InDesign 2024"
		tell document 1
			set horizontal measurement units of view preferences to myUnits
			set vertical measurement units of view preferences to myUnits
		end tell
	end tell
end mySetUnits
on myMakeRectangle(myPage, myBounds, myString, myFillColor, myStrokeColor, myStrokeWeight)
	tell application "Adobe InDesign 2024"
		tell myPage
			set myRectangle to make rectangle with properties {geometric bounds:myBounds, name:myString, fill color:myFillColor, stroke color:myStrokeColor, stroke weight:myStrokeWeight}
			return myRectangle
		end tell
	end tell
end myMakeRectangle
on myMakeTextFrame(myPage, myBounds, myString, myFontName, myPointSize, myJustification, myFitToContent)
	tell application "Adobe InDesign 2024"
		set myFont to font myFontName
		tell myPage
			set myTextFrame to make text frame with properties {geometric bounds:myBounds}
			set contents of insertion point 1 of myTextFrame to myString
			tell text 1 of parent story of myTextFrame
				set fill color to "Black"
				set point size to myPointSize
				set justification to myJustification
				set applied font to myFont
			end tell
			if myFitToContent is true then
				tell myTextFrame to fit given frame to content
			end if
			return myTextFrame
		end tell
	end tell
end myMakeTextFrame
on myMakeColor(myColorName, myColorSpace, myColorModel, myColorValue)
	tell application "Adobe InDesign 2024"
		tell document 1
			try
				set myColor to color myColorName
				set properties of myColor to {model:myColorModel, space:myColorSpace, color value:myColorValue}
			on error
				set myColor to make color with properties {model:myColorModel, space:myColorSpace, color value:myColorValue, name:myColorName}
			end try
		end tell
	end tell
end myMakeColor
