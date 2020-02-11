import Quick
import Nimble
@testable import NYT

class HomeScreenPresenterSpec: QuickSpec {
    override func spec() {
        describe("HomeScreenPresenter") {
            
            var uut: HomeScreenPresenter?
            let interactor = MockHomeScreenInteractor()
            let router = MockHomeScreenRouter()
            let view = MockHomeScreenViewController()
            
            beforeEach {
                uut = HomeScreenPresenter(interface: view, interactor: interactor, router: router)
            }
            
            describe("when .getArticles()") {
                
                describe("when .page is 0") {
                    beforeEach {
                        uut?.getArticles(searchText: "some text", page: 0)
                    }
                    
                    it("calls .interactor.getArticles()") {
                        let interactor = uut?.interactor as? MockHomeScreenInteractor
                        expect(interactor?.getArticlesWasCalled).to(beTrue())
                    }
                    
                    describe("that call") {
                        it("has .searchText equal to 'some text'") {
                            let interactor = uut?.interactor as? MockHomeScreenInteractor
                            expect(interactor?.searchText).to(equal("some text"))
                        }
                        
                        it("has .page equal to 0") {
                            let interactor = uut?.interactor as? MockHomeScreenInteractor
                            expect(interactor?.page).to(equal(0))
                        }
                    }
                    
                    it("calls .view.setIsLoading(true)") {
                        let view = uut?.view as? MockHomeScreenViewController
                        expect(view?.setIsLoadingWasCalled).toEventually(beTrue())
                        expect(view?.isLoading).toEventually(beTrue())
                    }
                }
                
                
                describe("when .page is not 0") {
                    beforeEach {
                        uut?.getArticles(searchText: "some text", page: 1)
                    }
                    
                    it("calls .interactor.getArticles()") {
                        let interactor = uut?.interactor as? MockHomeScreenInteractor
                        expect(interactor?.getArticlesWasCalled).to(beTrue())
                    }
                    
                    describe("that call") {
                        it("has .searchText equal to 'some text'") {
                            let interactor = uut?.interactor as? MockHomeScreenInteractor
                            expect(interactor?.searchText).to(equal("some text"))
                        }
                        
                        it("has .page equal to 1") {
                            let interactor = uut?.interactor as? MockHomeScreenInteractor
                            expect(interactor?.page).to(equal(1))
                        }
                    }
                }
                
            }
            
            describe("when .onArticlesLoaded()") {
                beforeEach {
                    let articles = [Article(), Article()]
                    uut?.onArticlesLoaded(articles: articles)
                }
                
                it("calls .view.setIsLoading(true)") {
                    let view = uut?.view as? MockHomeScreenViewController
                    expect(view?.setIsLoadingWasCalled).toEventually(beTrue())
                    expect(view?.isLoading).toEventually(beFalse())
                }
                
                it("calls .view.articlesLoaded()") {
                    let view = uut?.view as? MockHomeScreenViewController
                    expect(view?.articlesLoadedWasCalled).to(beTrue())
                    expect(view?.articles?.count).toEventually(equal(2))
                }
            }
            
            describe("when .articleSelected()") {
                beforeEach {
                    let article = Article(id: "some id")
                    uut?.articleSelected(article: article)
                }
                
                it("calls .router.routeToDetailScreen()") {
                    let router = uut?.router as? MockHomeScreenRouter
                    expect(router?.routeToDetailScreenWasCalled).to(beTrue())
                    expect(router?.article?.id).to(equal("some id"))
                }
            }
            
            describe("when .onError()") {
                beforeEach {
                    let error = NYTError(title: "some title", message: "some message")
                    uut?.onError(error: error)
                }
                
                it("calls .view.setIsLoading(false)") {
                    let view = uut?.view as? MockHomeScreenViewController
                    expect(view?.setIsLoadingWasCalled).toEventually(beTrue())
                    expect(view?.isLoading).toEventually(beFalse())
                }
                
                it("calls .view.displayError()") {
                    let view = uut?.view as? MockHomeScreenViewController
                    expect(view?.displayErrorWasCalled).to(beTrue())
                    expect(view?.mTitle).toEventually(equal("some title"))
                    expect(view?.message).toEventually(equal("some message"))
                }
            }
            
            describe("when .onPaginationError()") {
                beforeEach {
                    let error = NYTError(title: nil, message: nil)
                    uut?.onPaginationError(error: error)
                }
                
                it("calls .view.setIsLoading(false)") {
                    let view = uut?.view as? MockHomeScreenViewController
                    expect(view?.setIsLoadingWasCalled).to(beTrue())
                    expect(view?.isLoading).to(beFalse())
                }
            }
        }
    }
}
