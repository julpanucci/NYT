import Quick
import Nimble
@testable import NYT

class HomeScreenViewControllerSpec: QuickSpec {
    override func spec() {
        describe("HomeViewController") {

            var uut: HomeScreenViewController?

            beforeEach {
                uut = HomeScreenBuilder.createModule() as? HomeScreenViewController
            }

            describe("when .viewDidLoad()") {

                beforeEach {
                    uut?.viewDidLoad()
                }

                fit("sets .view.backgroundColor to UIColor(red: 0.01, green: 0.51, blue: 0.56, alpha: 1.00)") {
                    expect(uut?.view.backgroundColor).to(equal(UIColor(red: 0.01, green: 0.51, blue: 0.56, alpha: 1.00)))
                }
            }
        }
    }
}
