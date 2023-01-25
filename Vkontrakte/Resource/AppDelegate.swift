//
//  AppDelegate.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 17.10.2022.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
//        let item = Entity()
//        item.id = 0
//        item.name = "Андрей"
//        item.lastName = "Поздняков"
//        do{
////            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
////            let realm = try Realm(configuration: config)
//            let realm = try Realm()
//            print(realm.configuration.fileURL)
//            realm.beginWrite()
//            realm.add(item)
//            try realm.commitWrite()
//        } catch {
//            print(error)
//            
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

