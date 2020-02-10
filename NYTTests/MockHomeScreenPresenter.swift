import Quick
import Nimble
@testable import NYT

class MockHomeScreenPresenter: HomeScreenPresenterProtocol {

    var getArticlesWasCalled = false
    var onArticlesLoadedWasCalled = false
    var onErrorWasCalled = false
    var onPaginationErrorWasCalled = false
    var articlesSelectedWasCalled = false

    var searchText: String?
    var page: Int?

    var articles: [Article]?
    var article: Article?

    var error: Error?

    func getArticles(searchText: String, page: Int) {
        getArticlesWasCalled = true
        self.searchText = searchText
        self.page = page
    }

    func onArticlesLoaded(articles: [Article]) {
        onArticlesLoadedWasCalled = true
        self.articles = articles
    }

    func onError(error: Error) {
        onErrorWasCalled = true
        self.error = error
    }

    func onPaginationError(error: Error) {
        onPaginationErrorWasCalled = true
        self.error = error
    }

    func articleSelected(article: Article) {
        articlesSelectedWasCalled = true
        self.article = article
    }

}
