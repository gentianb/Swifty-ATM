//
//  AppDelegate.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/19/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        DataSource.instance.startStandardUserFIRObserve()
        
//
//        let ref = Database.database().reference().child("Admins")
//        ref.childByAutoId().setValue(["userName" : "Genti", "userPassword" : "1234"])
//        ref.childByAutoId().setValue(["userAccountNumber" : "13001", "userAccountPIN" : "5234", "userName" : "Fatos", "userSurname" : "Nano" , "userBalance" : "0"])
//        ref.childByAutoId().setValue(["userAccountNumber" : "12010", "userAccountPIN" : "1312", "userName" : "Apple", "userSurname" : "Steve", "userBalance" : "420" ])
//        ref.childByAutoId().setValue(["userAccountNumber" : "23001", "userAccountPIN" : "7631", "userName" : "Jobs", "userSurname" : "North", "userBalance" : "-10" ])
//        ref.childByAutoId().setValue(["userAccountNumber" : "40301", "userAccountPIN" : "5542", "userName" : "Kanye", "userSurname" : "West", "userBalance" : "-50" ])

        return true
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

