import UIKit

@testable import NYT

class MockHomeScreenInteractor: HomeScreenInteractorProtocol {
    var presenter: HomeScreenPresenterProtocol?

    var getArticlesWasCalled = false
    var searchText: String?
    var page: Int?

    func getArticles(searchText: String, page: Int) {
        getArticlesWasCalled = true
        self.searchText = searchText
        self.page = page
    }
}
