@testable import NYT

import UIKit

class MockTableView: UITableView {
    var reloadDataWasCalled = false

    override func reloadData() {
        reloadDataWasCalled = true
    }
}
