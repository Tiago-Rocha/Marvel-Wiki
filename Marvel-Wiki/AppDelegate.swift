//
//  AppDelegate.swift
//  Marvel-Wiki
//
//  Created by Tiago Rocha on 28/04/2019.
//  Copyright © 2019 Tiago Rocha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainNavigationController = UINavigationController()
        let vc = DependencyGraph.shared.getCharacterListViewController()
        mainNavigationController.addChild(vc)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainNavigationController
        return true
    }}

