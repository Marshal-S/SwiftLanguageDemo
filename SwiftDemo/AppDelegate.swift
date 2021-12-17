//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by Marshal on 2021/11/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, extensionProtocol {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        BaseLanguageModel.baseLanguage() //调用类方法
        BaseLanguageModel().baseLanguage1() //调用对象方法,需要创建对象，然后调用
        
        WrapperTestClass().setup()
        
        initDeinitClass(aObj: "", bObj: "")
        
        OperatorFuctionModel().test()
        
        self.testPrint()
        
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

