//
//  AppDelegate.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 10/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
//

import UIKit
import SharkORM
import Firebase
import SwiftyJSON
import DropDown
import FBSDKLoginKit
import IQKeyboardManagerSwift
import GoogleMobileAds
import SwiftyStoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SRKDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)

		IQKeyboardManager.sharedManager().enable = true
		
		GADMobileAds.configure(withApplicationID: Subterminal.getKey(key: "admob_appid"))

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.makeKeyAndVisible()
		window?.rootViewController = TabBarController()
		window?.backgroundColor = UIColor.white
		
        SharkORM.setDelegate(self)
        SharkORM.openDatabaseNamed("Subterminal")
		
		FIRApp.configure()
		
		API.initAPI()
		
		//Init the user once
		if(Subterminal.user.isLoggedIn()) {
			API.instance.getUser()
		}
		
		SwiftyStoreKit.completeTransactions(atomically: false) { products in
			for product in products {
				if product.transaction.transactionState == .purchased || product.transaction.transactionState == .restored {
					if product.needsFinishTransaction {
						if let receiptData = SwiftyStoreKit.localReceiptData {
							let receipt = receiptData.base64EncodedString()
							API.instance.sendPurchaseReceipt(receipt: receipt)
						}
						
						SwiftyStoreKit.finishTransaction(product.transaction)
					}
					print("purchased: \(product)")
				}
			}
		}
		
		DropDown.startListeningToKeyboard()
		
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

	
	func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
		return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
	}

}

