import Quick
import Nimble
@testable import NYT

class HomeScreenInteractorSpec: QuickSpec {
    override func spec() {
        describe("HomeScreenInteractor") {
            
            var uut: HomeScreenInteractor?
            let mockPresenter = MockHomeScreenPresenter()
            
            beforeEach {
                uut = HomeScreenInteractor()
                uut?.presenter = mockPresenter
            }
            
            describe("when .getArticles()") {
                beforeEach {
                    let service = MockArticleService()
                    uut?.articleService = service
                    uut?.getArticles(searchText: "some text", page: 7)
                }
                
                it("calls .articleService.getArticles()") {
                    let service = uut?.articleService as? MockArticleService
                    expect(service?.getArticlesWasCalled).to(beTrue())
                }
                
                describe("that call") {
                    describe("when .result in completion is .success") {
                        beforeEach {
                            let service = uut?.articleService as? MockArticleService
                            service?.completion?(.success([Article()]))
                        }
                        
                        it("calls .presenter.onArticlesLoaded()") {
                            let presenter = uut?.presenter as? MockHomeScreenPresenter
                            expect(presenter?.onArticlesLoadedWasCalled).toEventually(beTrue())
                            expect(presenter?.articles?.count).to(equal(1))
                        }
                    }
                    
                    describe("when .result in completion is .failure") {
                        describe("when .page is greater than 0") {
                            beforeEach {
                                uut?.getArticles(searchText: "some text", page: 2)
                                let service = uut?.articleService as? MockArticleService
                                service?.completion?(.failure(NYTError()))
                            }
                            
                            it("calls .presenter.onPaginationError()") {
                                let presenter = uut?.presenter as? MockHomeScreenPresenter
                                expect(presenter?.onPaginationErrorWasCalled).to(beTrue())
                            }
                        }
                        
                        describe("when .page is 0") {
                            beforeEach {
                                uut?.getArticles(searchText: "some text", page: 0)
                                let service = uut?.articleService as? MockArticleService
                                service?.completion?(.failure(NYTError()))
                            }
                            
                            it("calls .presenter.onError()") {
                                let presenter = uut?.presenter as? MockHomeScreenPresenter
                                expect(presenter?.onErrorWasCalled).to(beTrue())
                            }
                        }
                    }
                    
                }
            }
        }
    }
}
