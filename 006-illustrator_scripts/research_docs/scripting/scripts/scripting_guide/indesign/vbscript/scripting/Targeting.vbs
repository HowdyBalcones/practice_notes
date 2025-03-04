Rem Targeting.vbs
Rem An InDesign VBScript
Rem 
Rem Target the script to a particular version of InDesign

Rem <fragment>
Rem Target InDesign CC:
Set myApp = CreateObject("InDesign.Application.2024")
Rem Target the last version of InDesign
Set myApp = CreateObject("InDesign.Application")
Rem </fragment>
