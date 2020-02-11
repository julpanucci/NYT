@testable import NYT

class MockReachabilityService: ReachabilityService {
    
    var connectionIsUnavailableToReturn = false
    
    override func connectionIsUnavailable() -> Bool {
        return self.connectionIsUnavailableToReturn
    }
}
