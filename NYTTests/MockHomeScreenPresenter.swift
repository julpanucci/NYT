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

    func getArticles(searchText: String, page: Int) {
        getArticlesWasCalled = true
        self.searchText = searchText
        self.page = page
    }

    func onArticlesLoaded(articles: [Article]) {
        onArticlesLoadedWasCalled = true
    }

    func onError(error: Error) {
        onErrorWasCalled = true
    }

    func onPaginationError(error: Error) {
        onPaginationErrorWasCalled = true
    }

    func articleSelected(article: Article) {
        articlesSelectedWasCalled = true
    }

}
