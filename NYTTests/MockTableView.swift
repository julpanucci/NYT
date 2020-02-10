@testable import NYT

import UIKit

class MockTableView: UITableView {
    var reloadDataWasCalled = false
    var deselectRowWasCalled = false

    var indexPath: IndexPath?
    var animated: Bool?

    override func reloadData() {
        reloadDataWasCalled = true
    }

    override func deselectRow(at indexPath: IndexPath, animated: Bool) {
        deselectRowWasCalled = true
        self.indexPath = indexPath
        self.animated = animated
    }
}
