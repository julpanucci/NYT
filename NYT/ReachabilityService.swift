//
//  ReachabilityService.swift
//  NYT
//
//  Created by Julian Panucci on 2/11/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import Foundation

class ReachabilityService {
    static let shared = ReachabilityService()
    
    let reachability = try! Reachability()
    
    init() {
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    func connectionIsUnavailable() -> Bool {
        return reachability.connection == .unavailable
    }
}
