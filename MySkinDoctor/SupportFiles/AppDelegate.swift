//
//  AppDelegate.swift
//  MySkinDoctor
//
//  Created by Alex on 14/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import AWSCognito

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		IQKeyboardManager.sharedManager().enable = true // controls the scrollviews and uitextfields
		ThemeManager.applyTheme()
		updateRootVC()
		
		// Amazon AWS S3
		let region = AWSRegionType.euWest1
		let cognitoIdentityPoolId: String = "eu-west-1:c940565a-9d4e-4aa8-b054-e6a2cf9aca54"
		let credentialsProvider = AWSCognitoCredentialsProvider(regionType: region, identityPoolId: cognitoIdentityPoolId)
		let defaultServiceConfiguration = AWSServiceConfiguration(region: region, credentialsProvider: credentialsProvider)
		AWSServiceManager.default().defaultServiceConfiguration = defaultServiceConfiguration
		
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
		// Saves changes in the application's managed object context before the application terminates.
		CoreDataStack.saveContext()
	}
	
	func updateRootVC() {
		
		let isUserLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultConsts.isUserLoggedIn)
		var rootVC : UIViewController?
			
		if isUserLoggedIn == true {
			rootVC = UIStoryboard(name: Storyboard.mainStoryboardName, bundle: nil).instantiateViewController(withIdentifier: Storyboard.mainTabNavigationControllerId)
		} else{
			rootVC = UIStoryboard(name: Storyboard.loginStoryboardName, bundle: nil).instantiateViewController(withIdentifier: Storyboard.loginNavigationControllerId)
		}
		
		let appDelegate = UIApplication.shared.delegate as! AppDelegate
		appDelegate.window?.rootViewController = rootVC
	}
}

