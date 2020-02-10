import Quick
import Nimble
@testable import NYT

class HomeScreenRouterSpec: QuickSpec {
    override func spec() {
        describe("HomeScreenRouter") {
            
            var uut: HomeScreenRouter?
            var viewController: MockHomeScreenViewController?
            var mockNav: MockNavigationController?
            
            beforeEach {
                uut = HomeScreenRouter()
                mockNav = MockNavigationController()
                viewController = MockHomeScreenViewController()
                mockNav?.setViewControllers([viewController!], animated: false)
                uut?.viewController = viewController
            }
            
            describe("when .routeToDetailScreen()") {
                
                beforeEach {
                    uut?.routeToDetailScreen(article: Article(id:"some id"))
                }
                
                it("calls .viewController.navigationController.pushViewController()") {
                    let navController = uut?.viewController?.navigationController as? MockNavigationController
                    expect(navController?.pushViewControllerWasCalled).toEventually(beTrue())
                }
                
                describe("that call") {
                    it("pushes detailVC of type DetailScreenViewController") {
                        let navController = uut?.viewController?.navigationController as? MockNavigationController
                        expect(navController?.pushedViewController).to(beAnInstanceOf(DetailScreenViewController.self))
                        
                        let detailVC = navController?.pushedViewController as? DetailScreenViewController
                        expect(detailVC?.article?.id).to(equal("some id"))
                    }
                }
            }
        }
    }
}
