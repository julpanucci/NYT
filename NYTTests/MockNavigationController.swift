import UIKit

@testable import NYT

class MockNavigationController: UINavigationController {
    
    var pushViewControllerWasCalled = false
    var pushedViewController: UIViewController?
    var animated: Bool?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.pushViewControllerWasCalled = true
        self.pushedViewController = viewController
        self.animated = animated
    }
}
