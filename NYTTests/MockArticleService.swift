@testable import NYT

class MockArticleService: ArticleService {
    var getArticlesWasCalled = false
    
    var searchText: String?
    var page: Int?
    var completion: ArticleService.ArticleResult?
    
    override func getArticles(searchText: String, forPage page: Int, completion: @escaping ArticleService.ArticleResult) {
        getArticlesWasCalled = true
        self.searchText = searchText
        self.page = page
        self.completion = completion
    }
}
