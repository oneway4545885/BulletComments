//
//  AppDelegate.swift
//  test
//
//  Created by 王偉 on 2016/9/5.
//  Copyright © 2016年 王偉. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    internal func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        FIRApp.configure()
        return true
    }


}

