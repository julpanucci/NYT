//
//  AppDelegate.swift
//  NYT
//
//  Created by Julian Panucci on 2/4/20.
//  Copyright © 2020 Panucci. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = HomeScreenBuilder.createModule()
        window?.makeKeyAndVisible()
        
        return true
    }
}

