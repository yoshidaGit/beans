//
//  AppDelegate.swift
//  member'sCal
//
//  Created by 吉田air on 2015/06/09.
//  Copyright (c) 2015年 yoshidajumokui.llc. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
//------------------------------------------作業員テーブル
    var memberName:[String] = ["吉田","yoshida","sakonaka"]
    var memberStart:[String] = ["08:00","08:30","09:30"]
    var memberFinish:[String] = ["17:00","17:30","18:00"]
    var memberBeans:[Int] = [2,0,1]
//    var memberDate:[String] = []
//    var memberGenba:[String] = []
    var memberMon:[Bool] = [false,true,false]
    var memberTue:[Bool] = [false,true,true]
    var memberWen:[Bool] = [false,true,false]
    var memberThu:[Bool] = [false,true,true]
    var memberFri:[Bool] = [false,true,false]
    var memberSta:[Bool] = [false,true,true]
    var memberSun:[Bool] = [false,true,false]

//-------------------------------------------カレンダーテーブル
    var calGenbaName:[String] = ["蒔田","清水が丘","保土ケ谷"]
    var calStartTime:[String] = ["08:00","13:00","08:30"]
    var calFinishTime:[String] = ["17:30","15:00","22:00"]
    var calDay:[String] = ["2016/04/01","2016/04/02","2016/04/01"]//日付の書式がよくわからないので適当
    var NSCalDay:[NSDate] = []//日付をNSDate型で保持（まだ未着手）
    
    
 //------------------------------------------実務作業員テーブル
    //    var calBeans:[Int] = [2,1,0]//ここは更に入れ子にするか、またはビーンズを追加するたびにレコードを追加するか・・
    var calBeansName:[String] = ["吉田","yoshida","sakonaka","yoshida"]
    var calBeansStartTime:[String] = ["08:00","09:00","09:00","08:30"]//レコードごとに時間調整出来るようにする
    var calBeansFinishTime:[String] = ["12:00","17:00","18:00","17:30"]//レコードごとに時間調整出来るようにする
    var calBeansDay:[String] = ["2016/04/01","2016/04/01","2016/04/01","2016/04/02"]
    
//-------------------------------------------ビーンズフィールド
    let Beans:[UIImage] = [
        UIImage(named:"1.png")!,
        UIImage(named:"2.png")!,
        UIImage(named:"3.png")!
    ]
    
    
    
//-------------------------------------------その他変数
    var memberIndex = 0
    var calIndex = 0
    var calBeansIndex = 0
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
       self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "jp.co.yoshidajumokui.member_sCal" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] 
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("member_sCal", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("member_sCal.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges {
                do {
                    try moc.save()
                } catch let error1 as NSError {
                    error = error1
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    NSLog("Unresolved error \(error), \(error!.userInfo)")
                    abort()
                }
            }
        }
    }

}

