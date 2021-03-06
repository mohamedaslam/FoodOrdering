//
//  AppDelegate.swift
//  FoodOrdering
//
//  Created by Mohammed Aslam Shaik on 2019/11/21.
//  Copyright © 2019 Mohammed Aslam Shaik. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GIDSignInDelegate {
 

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 3.0)
        let rootVC = MainHomeViewController()
        //let navController = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = rootVC
        GIDSignIn.sharedInstance().clientID = "6359015885-ta1id9oaphn7ui8kki0606hjctd51833.apps.googleusercontent.com"
        // Facebook sign-in.
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions);
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
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
           
        let  facebookhandled = ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
           
        let  googlehandled = GIDSignIn.sharedInstance().handle(url)

      
           return facebookhandled || googlehandled
       }
       
      
       func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
                 withError error: Error!) {
           // Perform any operations when the user disconnects from app here.
           // ...
       }
       
       func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
                 withError error: Error!) {
           if let error = error {
               print("\(error.localizedDescription)")
           } else {
               // Perform any operations on signed in user here.
               let userId = user.userID                  // For client-side use only!
               let idToken = user.authentication.idToken // Safe to send to the server
               let fullName = user.profile.name
               let givenName = user.profile.givenName
               let familyName = user.profile.familyName
               let email = user.profile.email
          //      ...
               
                           print(userId!)
                           print("idToken")
                           print(fullName!)
                           print(givenName!)
                           print(familyName!)
                           print(email!)
           }
       }
       

}

