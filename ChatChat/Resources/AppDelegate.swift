//
//  AppDelegate.swift
//  ChatChat
//
//  Created by Mehmet Bilir on 18.11.2022.
//

import UIKit

import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    let loginNavVC = UINavigationController(rootViewController: LoginViewController())
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        setRootVC()
        return true
    }

    private func setRootVC() {
        
        if Auth.auth().currentUser == nil {
            window?.rootViewController = loginNavVC
        }
        else {
            
            window?.rootViewController = MainTabBarController()
        }
        
    }
   

}

