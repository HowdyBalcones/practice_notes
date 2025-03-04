Rem CreateArticle.vbs
Rem An InDesign VBScript
Rem
Rem Show how to retrieve articles from a document and
Rem how to create new articles.
main
Function main()
	Set myInDesign = CreateObject("InDesign.Application.2024")
	mySetup myInDesign
	mySnippet myInDesign
	myTeardown myInDesign
End Function
Function mySetup(myInDesign)
	Set myDocument = myInDesign.Documents.Add
End Function
Function mySnippet(myInDesign)
	Rem ![Get articles.]
	Set myDocument = myInDesign.Documents.Item(1)
	Set articles = myDocument.Articles
	Rem ![Get articles.]
	
	Rem ![Add article.]
	Set article1 = myDocument.Articles.Add("Article1", True)
	Rem ![Add article.]
	Rem The second parameter specifies the article's export status.
	Set article2 = myDocument.Articles.Add("Article2", False)	
End Function
Function myTeardown(myInDesign)
End Function