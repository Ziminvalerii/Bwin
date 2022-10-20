//
//  AppDelegate.swift
//  PlayOjo
//
//  Created by Tanya Koldunova on 28.09.2022.
//

import UIKit
import WebKit
//import GoogleMobileAds

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let rootNavVC = NavigationController()
        let builder = Builder()
        let router = Router(navigationController: rootNavVC, builder: builder)
        router.load()
        window?.rootViewController = rootNavVC
        playBackgroundMusic()
        UserDefaultsValues.brightness = Float(UIScreen.main.brightness)
        return true
    }
    
    func openGame() {
        
    }
    
}
