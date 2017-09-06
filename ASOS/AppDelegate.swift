//
//  AppDelegate.swift
//  ASOS
//
//  Created by Billybatigol on 06/09/2017.
//  Copyright © 2017 Vasileios Loumanis. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = AppNavigationController.sharedInstance.splashPageVC
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
