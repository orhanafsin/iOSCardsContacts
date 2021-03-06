//
//  AppDelegate.swift
//  Cards Contacts
//
//  Created by Nicholas Arduini on 6/23/19.
//  Copyright © 2019 Nicholas Arduini. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        StorageService.migrateVersion()
        
        if(!Reachability.isConnectedToNetwork()){
            DispatchQueue.main.async {
                if let vc = self.window?.rootViewController {
                    vc.presentAlert(withMessage: Constants.NOT_CONNECTED_TO_THE_INTERNET)
                }
            }
        }
        
        //set current view controller depending if the user is signed in
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: Constants.MAIN_STORYBOARD, bundle: nil)
        if AuthService().isLoggedIn() {
            let initialViewController = storyboard.instantiateViewController(withIdentifier: Constants.MAIN_TAB_VC)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        } else {
            let initialViewController = storyboard.instantiateViewController(withIdentifier: Constants.LOGIN_VC)
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        }
        
        // remove bar back button titles
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)
        
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
    
    func changeRootViewController(with identifier:String!) {
      let storyboard = self.window?.rootViewController?.storyboard
      let desiredViewController = storyboard?.instantiateViewController(withIdentifier: identifier);

      let snapshot:UIView = (self.window?.snapshotView(afterScreenUpdates: true))!
      desiredViewController?.view.addSubview(snapshot);

      self.window?.rootViewController = desiredViewController;

      UIView.animate(withDuration: 0.3, animations: {() in
        snapshot.layer.opacity = 0;
        snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
        }, completion: {
          (value: Bool) in
          snapshot.removeFromSuperview();
      });
    }
}

