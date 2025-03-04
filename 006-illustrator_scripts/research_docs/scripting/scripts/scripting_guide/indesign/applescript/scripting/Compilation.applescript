--Compilation.applescript
--An InDesign AppleScript
--
--Use a script written for an earlier Indesign version's dictionary in the current version.
--<fragment>
tell application "Adobe InDesign 2024" --target CC
    using terms from application "InDesign CS3" --compile using CS3
        --InDesign CS3 version script goes here.
    end using terms from
end tell
--</fragment>
