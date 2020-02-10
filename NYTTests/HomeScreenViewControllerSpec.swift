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

                describe("when .retryPaginatedLoad()") {
                    beforeEach {
                        uut?.searchText = "some text"
                        uut?.page = 4
                        uut?.retryPaginatedLoad()
                    }

                    it("sets .tableView.tableFooterView to .paginationLoadingView") {
                        expect(uut?.tableView.tableFooterView).to(equal(uut?.paginationLoadingView))
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

                        it("has page equal to 4") {
                            let presenter = uut?.presenter as? MockHomeScreenPresenter
                            expect(presenter?.page).to(equal(4))
                        }
                    }
                }

                describe("when .articlesLoaded()") {
                    beforeEach {
                        uut?.articles = [Article]()
                        let newArticles = [Article(), Article()]
                        uut?.tableView = MockTableView()
                        uut?.articlesLoaded(articles: newArticles)
                    }

                    it("appends the articles passed in to .articles") {
                        expect(uut?.articles.count).to(equal(2))
                    }

                    it("sets .tableView.tableFooterView to a blank UIView") {
                        expect(uut?.tableView.tableFooterView).toNot(equal(uut?.paginationLoadingView))
                        expect(uut?.tableView.tableFooterView).toNot(equal(uut?.paginationErrorView))
                        expect(uut?.tableView.tableFooterView).toNot(beNil())
                    }

                    it("calls .tableView.reloadData()") {
                        let mockTableView = uut?.tableView as? MockTableView
                        expect(mockTableView?.reloadDataWasCalled).to(beTrue())
                    }
                }

                describe("when .displayPaginationError()") {
                    beforeEach {
                        uut?.displayPaginationError()
                    }

                    it("sets .tableView.tableFooterView to .paginationErrorView") {
                        expect(uut?.tableView.tableFooterView).to(equal(uut?.paginationErrorView))
                    }
                }

                describe("when .numberOfSections()") {
                    var result: Int?
                    beforeEach {
                        result = uut!.numberOfSections(in: uut!.tableView)
                    }

                    it("returns 1") {
                        expect(result).to(equal(1))
                    }
                }

                describe("when .numberOfRowsInSection()") {
                    var result: Int?
                    beforeEach {
                        uut?.articles = [Article(), Article(), Article()]
                        result = uut!.tableView(uut!.tableView, numberOfRowsInSection: 1)
                    }

                    it("returns .articles.count") {
                        expect(result).to(equal(3))
                    }
                }

                describe("when .cellForRowAt()") {
                    var cell: UITableViewCell?

                    beforeEach {
                        let article0 = Article(id: "1234")
                        uut?.articles = [article0]
                        cell = uut?.tableView(uut!.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                    }

                    it("deques a cell from tableView of type ArticleCell") {
                        expect(cell).to(beAnInstanceOf(ArticleCell.self))
                    }

                    describe("that cell") {
                        it("has a .article equal to article at .articles[indexPath.row]") {
                            let articleCell = cell as? ArticleCell
                            expect(articleCell?.article?.id).to(equal("1234"))
                        }
                    }
                }

                describe("when .willDisplayCell()") {
                    beforeEach {
                        uut?.articles = [Article(), Article(), Article()]
                        uut?.page = 1
                        uut?.searchText = "football"
                        uut?.tableView(uut!.tableView, willDisplay: UITableViewCell(), forRowAt: IndexPath(row: 2, section: 0))
                    }

                    it("increments .page by one") {
                        expect(uut?.page).to(equal(2))
                    }

                    it("sets .tableView.tableFooterView to .paginationLoadingView") {
                        expect(uut?.tableView.tableFooterView).to(equal(uut?.paginationLoadingView))
                    }

                    it("calls .presenter.getArticles()") {
                        let presenter = uut?.presenter as? MockHomeScreenPresenter
                        expect(presenter?.getArticlesWasCalled).to(beTrue())
                    }

                    describe("that call") {
                        it("has searchText equal to 'football'") {
                            let presenter = uut?.presenter as? MockHomeScreenPresenter
                            expect(presenter?.searchText).to(equal("football"))
                        }

                        it("has page equal to 2") {
                            let presenter = uut?.presenter as? MockHomeScreenPresenter
                            expect(presenter?.page).to(equal(2))
                        }
                    }
                }

                describe("when .didSelectRowAt()") {
                    beforeEach {
                        uut?.articles = [Article(id: "456")]
                        uut?.tableView = MockTableView()
                        uut?.tableView(uut!.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                    }

                    it("calls .tableView.deselectRow()") {
                        let tableView = uut?.tableView as? MockTableView
                        expect(tableView?.deselectRowWasCalled).to(beTrue())
                    }

                    describe("that call") {
                        it("has .indexPath equal to the indexPath passed in") {
                            let tableView = uut?.tableView as? MockTableView
                            expect(tableView?.indexPath).to(equal(IndexPath(row: 0, section: 0)))
                        }

                        it("has .animated equal to true") {
                            let tableView = uut?.tableView as? MockTableView
                            expect(tableView?.animated).to(beTrue())
                        }
                    }

                    it("calls . presenter.articleSelected()") {
                        let presenter = uut?.presenter as? MockHomeScreenPresenter
                        expect(presenter?.articlesSelectedWasCalled).to(beTrue())
                    }

                    describe("that call") {
                        it("has an article equal to article at .articles[indexPath.row]") {
                            let presenter = uut?.presenter as? MockHomeScreenPresenter
                            expect(presenter?.article?.id).to(equal("456"))
                        }
                    }
                }

                describe("when .textFieldShouldReturn()") {
                    describe("when .textField.text pass in is not nil") {
                        var result: Bool = false
                        beforeEach {
                            let textField = UITextField()
                            textField.text = "hello"
                            result = uut!.textFieldShouldReturn(textField)
                        }

                        it("returns true") {
                            expect(result).to(beTrue())
                        }

                        it("sets .searchText equal to text passed in") {
                            expect(uut?.searchText).to(equal("hello"))
                        }

                        it("sets .title equal to text passed in ") {
                            expect(uut?.title).to(equal("hello"))
                        }
                    }

                    describe("when .textField.text passed in is nil") {
                        var result: Bool = false
                        beforeEach {
                            let textField = UITextField()
                            textField.text = nil
                            result = uut!.textFieldShouldReturn(textField)
                        }

                        it("returns true") {
                            expect(result).to(beTrue())
                        }

                        it("sets .searchText equal to text passed in") {
                            expect(uut?.searchText).to(equal(""))
                        }

                        it("sets .title equal to text passed in ") {
                            expect(uut?.title).to(equal(""))
                        }
                    }
                }
            }
        }
    }
}
