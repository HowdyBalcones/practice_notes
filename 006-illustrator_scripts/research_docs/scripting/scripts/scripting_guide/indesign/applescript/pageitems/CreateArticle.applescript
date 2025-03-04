--CreateArticle.applescript
--An InDesign AppleScript
--
--Shows how to retrieve articles from a document and
--how to create new articles.
main()
on main()
	mySetup()
	mySnippet()
	myTeardown()
end main
on mySetup()
	tell application "Adobe InDesign 2024"
		set myDocument to make document
	end tell
end mySetup
on mySnippet()
	tell application "Adobe InDesign 2024"
		--![Get articles.]
		set myDocument to document 1
		set myArticles to articles of myDocument
		--![Get articles.]
		
		tell myDocument
			--![Add article.]
			set newArticle1 to make article with properties {name:"Article1", article export status:true}
			--![Add article.]
			set newArticle2 to make article with properties {name:"Article2", article export status:false}
		end tell
	end tell
	
end mySnippet
on myTeardown()
end myTeardown