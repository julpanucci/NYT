import UIKit

@testable import NYT

class MockHomeScreenViewController: HomeScreenViewProtocol {
    var presenter: HomeScreenPresenterProtocol?
    
    var articlesLoadedWasCalled = false
    var displayErrorWasCalled = false
    var setIsLoadingWasCalled = false
    var displayPaginationErrorWasCalled = false
    
    var isLoading = false
    var articles: [Article]?
    var title: String?
    var message: String?
    
    func articlesLoaded(articles: [Article]) {
        articlesLoadedWasCalled = true
        self.articles = articles
    }
    
    func displayError(title: String, message: String) {
        displayErrorWasCalled = true
        self.title = title
        self.message = message
    }
    
    func setIsLoading(_ isLoading: Bool) {
        setIsLoadingWasCalled = true
        self.isLoading = isLoading
    }
    
    func displayPaginationError() {
        displayPaginationErrorWasCalled = true
    }
}
