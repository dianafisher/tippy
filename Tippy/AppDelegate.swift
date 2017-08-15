//
//  AppDelegate.swift
//  Tippy
//
//  Created by Diana Fisher on 8/10/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let appLaunchKey: String = "lastAppLaunchDate"

    func loadLastAppLaunchTime() {
        
        // Use the nil-coalescing operator (??) to unwrap optional value from UserDefaults or return a new Date() if the value is nil
        let lastAppLaunchDate = (UserDefaults.standard.object(forKey: appLaunchKey) as? Date) ?? Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm"
        let dateStr = dateFormatter.string(from: lastAppLaunchDate)
        print("lastAppLaunch: \(dateStr)")
            
        // Calculate how long it has been since the last app launch
        let now: Date = Date()
            
        print(dateFormatter.string(from: now))
            
        let timeInterval = now.timeIntervalSince(lastAppLaunchDate)
        print("timeInterval: \(timeInterval)")
        let minutes = timeInterval / 60.0
        print("minutes: \(minutes)")
            
        // If it has been longer than 10 minutes, clear out the last bill total.
        let tenMinutes: Double = 10.0 * 60
        if (timeInterval > tenMinutes) {
            UserDefaultsManager.lastBillAmount = 0.0
        }
        
    }
    
    func saveAppLaunchTime() {
        let dateTimeNow: Date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm"
        
        let dateStr = dateFormatter.string(from: dateTimeNow)
        print("saving launch date: \(dateStr)")
        UserDefaults.standard.set(dateTimeNow, forKey: appLaunchKey)

    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Load last app launch time
        loadLastAppLaunchTime()
        
        // Add custom nav bar image.
        let backgroundImage = UIImage(named: "nav_header")        
        UINavigationBar.appearance().setBackgroundImage(backgroundImage, for: .default)
        
        // Create purple color, #9FA0CC for tint color
        let red: CGFloat = CGFloat(Float(159)/255.0)
        let green: CGFloat = CGFloat(Float(160)/255.0)
        let blue: CGFloat = CGFloat(Float(204)/255.0)
        
        UINavigationBar.appearance().tintColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        // Save app launch time
        saveAppLaunchTime()
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

