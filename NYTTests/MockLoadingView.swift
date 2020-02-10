@testable import NYT

class MockLoadingView: LoadingView {

    var startLoadingWasCalled = false
    var stopLoadingWasCalled = false

    override func startLoading() {
        startLoadingWasCalled = true
    }

    override func stopLoading() {
        startLoadingWasCalled = true
    }
}
