import Quick
import Nimble
@testable import NYT

class HomeScreenViewControllerSpec: QuickSpec {
    override func spec() {
        describe("HomeViewController") {

            var uut: HomeScreenViewController?

            beforeEach {
                uut = HomeScreenBuilder.createModule() as? HomeScreenViewController
                uut?.presenter = MockHomeScreenPresenter()
                uut?.loadingView = MockLoadingView()
            }

            describe(".tableView") {
                it("has .footerView that is not nil") {
                    expect(uut?.tableView).toNot(beNil())
                }

                it("sets .keyboardDismissMode = .onDrag") {
                    expect(uut?.tableView.keyboardDismissMode).to(equal(.onDrag))
                }
            }

            describe("when .viewDidLoad()") {

                beforeEach {
                    uut?.viewDidLoad()
                }

                it("sets .view.backgroundColor to UIColor(red: 0.01, green: 0.51, blue: 0.56, alpha: 1.00)") {
                    expect(uut?.view.backgroundColor).to(equal(UIColor(red: 0.01, green: 0.51, blue: 0.56, alpha: 1.00)))
                }
            }

            describe("when .setIsLoading()") {
                describe("when .setIsLoading(true)") {
                    beforeEach {
                        uut?.setIsLoading(true)
                    }

                    it("calls .loadingView.startLoading()") {
                        let loadingView = uut?.loadingView as? MockLoadingView
                        expect(loadingView?.startLoadingWasCalled).to(beTrue())
                    }

                    it("sets .tableView.backgroundView.isHidden = false") {
                        expect(uut?.tableView.backgroundView?.isHidden).to(beFalse())
                    }

                }

                describe("when .setIsLoading(false)") {
                    beforeEach {
                        uut?.setIsLoading(false)
                    }

                    it("calls .loadingView.stopLoading()") {
                        let loadingView = uut?.loadingView as? MockLoadingView
                        expect(loadingView?.stopLoadingWasCalled).to(beFalse())
                    }

                    it("sets .tableView.backgroundView.isHidden = true") {
                        expect(uut?.tableView.backgroundView?.isHidden).to(beTrue())
                    }
                }

                describe("when .getInitialArticles()") {
                    describe("when .getInitialArticles() is called with empty text") {
                        beforeEach {
                            uut?.tableView = MockTableView()
                            uut?.getInitialArticles(searchText: "")
                        }

                        it("sets .page equal to 0") {
                            expect(uut?.page).to(equal(0))
                        }

                        it("clears all articles in .articles") {
                            expect(uut?.articles.count).to(equal(0))
                        }

                        it("calls .tableView.reloadData()") {
                            let tableView = uut?.tableView as? MockTableView
                            expect(tableView?.reloadDataWasCalled).to(beTrue())
                        }

                        it("does not .presenter.getArticles()") {
                            let presenter = uut?.presenter as? MockHomeScreenPresenter
                            expect(presenter?.getArticlesWasCalled).to(beFalse())
                        }
                    }

                    describe("when .getInitialArticles() is called with some text") {
                        beforeEach {
                            uut?.tableView = MockTableView()
                            uut?.getInitialArticles(searchText: "some text")
                        }

                        it("sets .page equal to 0") {
                            expect(uut?.page).to(equal(0))
                        }

                        it("clears all articles in .articles") {
                            expect(uut?.articles.count).to(equal(0))
                        }

                        it("calls .tableView.reloadData()") {
                            let tableView = uut?.tableView as? MockTableView
                            expect(tableView?.reloadDataWasCalled).to(beTrue())
                        }

                        it("calls .presenter.getArticles()") {
                            let presenter = uut?.presenter as? MockHomeScreenPresenter
                            expect(presenter?.getArticlesWasCalled).to(beTrue())
                        }

                        describe("that call") {
                            it("has searchText equal to 'some text'") {
                                let presenter = uut?.presenter as? MockHomeScreenPresenter
                                expect(presenter?.searchText).to(equal("some text"))
                            }

                            it("has page equal to 0") {
                                let presenter = uut?.presenter as? MockHomeScreenPresenter
                                expect(presenter?.page).to(equal(0))
                            }
                        }
                    }
                }
            }
        }
    }
}
