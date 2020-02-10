import UIKit

@testable import NYT

class MockHomeScreenRouter: HomeScreenRouterProtocol {
    
    var routeToDetailScreenWasCalled = false
    var article: Article?
    
    func routeToDetailScreen(article: Article) {
        routeToDetailScreenWasCalled = true
        self.article = article
    }
}
