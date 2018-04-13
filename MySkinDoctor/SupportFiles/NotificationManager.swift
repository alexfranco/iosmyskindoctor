//
//  NotificationManager.swift
//  Talk to a Doctor
//
//  Created by Nicholas Jones on 20/11/2017.
//  Copyright © 2017 TouchSoft. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate, MessagingDelegate {
	
	static let shared = NotificationManager()
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	//************************************************************************************************************************************************************//
	//MARK: - Messaging setup/registration
	//************************************************************************************************************************************************************//
	public func setup(_ application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
		if #available(iOS 10.0, *) {
			// For iOS 10 display notification (sent via APNS)
			UNUserNotificationCenter.current().delegate = self
			
			let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
			UNUserNotificationCenter.current().requestAuthorization(
				options: authOptions,
				completionHandler: {_, _ in })
		} else {
			let settings: UIUserNotificationSettings =
				UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
			application.registerUserNotificationSettings(settings)
		}
		
		Messaging.messaging().delegate = self
		application.registerForRemoteNotifications()
		connect() // TODO: is this needed?. It doesn't change behaviour in any way
		
		NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidBecomeActive), name: .UIApplicationDidBecomeActive, object: application)
		
		if let lo = launchOptions, let userInfo = lo[.remoteNotification] as? [AnyHashable: Any] {
			handleNotification(userInfo: userInfo) {
			}
		}
	}
	
	public func connect() {
		Messaging.messaging().shouldEstablishDirectChannel = true
	}
	
	private func disconnect() {
		Messaging.messaging().shouldEstablishDirectChannel = false
	}
	
	//************************************************************************************************************************************************************//
	//MARK: - Token Registration/Update
	//************************************************************************************************************************************************************//
	
	//PUBLIC: to be called whenever we need to register Firebase CM with out server
	public func registerUser() {
//		if Utils.userIsLoggedIn(), let fcmToken = Messaging.messaging().fcmToken{
//			registerFcmDeviceWithServer(fcmToken)
//		}
	}
	
	// iOS9 +
	// FIRMessagingDelegate - Token has been updated..... called only the first time it's registered (e.g. first run)
	func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//		if Utils.userIsLoggedIn() {
//			registerUser()
//		}
	}
	
	// Register the firebase token with the server
	private func registerFcmDeviceWithServer(_ refreshedToken: String) {
//		let userDefaults = UserDefaults.standard
//		if let sessionId = userDefaults.string(forKey: SessionData.KEY_SESSION_ID) {
//			ApiUtils.postRegisterDevice(sessionId, gcmToken: refreshedToken, completionHandler: { (success, statusCode, model) in
//				if (success) {
//					// Store GCM token
//					if let response = model, let token = response.regId {
//						userDefaults.setValue(token, forKey: SessionData.KEY_GCM_TOKEN)
//					}
//				}
//			})
//		}
	}
	
	//************************************************************************************************************************************************************//
	//MARK: - UIApplication Delegate
	//************************************************************************************************************************************************************//
	
	@objc func applicationDidBecomeActive(object: NSNotification) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		if let application = object.object as! UIApplication! {
			application.applicationIconBadgeNumber = 0;
		}
	}
	
	//MARK: - Notification methods that cannot be passed off
	func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
		// set firebase apns token
		//TODO: THIS HAS TO BE SET despite the swizzling documentation above. Why????
		Messaging.messaging().apnsToken = deviceToken
		
		// Register device
		//TODO: check we can leave this out. It works on short time basis. Register with server should happen whenever didReceiveRegistrationToken called anyway.
		// This is called everytime the app starts..... messaging:didReceiveRegistrationToken only called when get updated token. So registration with server here could be overkill
		//        if let refreshedToken = InstanceID.instanceID().token() {
		//            print("InstanceID token: \(refreshedToken)")
		//            registerFcmDeviceWithServer(refreshedToken)
		//        }
	}
	
	//************************************************************************************************************************************************************//
	//MARK: - Received Notification
	//************************************************************************************************************************************************************//
	//MARK: FCM APNs interface
	
	// iOS 9 +
	// Received notification: app open or closed
	// FB (and other sources) implies this is called when notification clicked but in reality it is called before displayed
	//TODO:  why does receiving trigger, not tapping?
	/* " When your app is in the background, iOS directs messages with the notification key to the system tray. A tap on a notification opens the app, and the content of the notification is passed to the didReceiveRemoteNotification callback in the AppDelegate." */
	public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
							fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
		// process notification
		print("application:didReceiveWithCompletion")
		handleNotification(userInfo: userInfo) {
			completionHandler(UIBackgroundFetchResult.newData)
		}
	}
	
	//Other form of "didReceiveRemoteNotification". Use not recommended by Apple
	func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
	}
	
	func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
		//This is requested by messaging delegate but never called? With shouldEstablishDirectChannel true or false
		//TODO: Why not called?
		print("didReceive:remoteMessage: " + remoteMessage.description)
	}
	
	
	//************************************************************************************************************************************************************//
	//MARK: - Clicked Notification
	//************************************************************************************************************************************************************//
	
	//called when clicked outside app (not inside)
	//Called to let your app know which action was selected by the user for a given notification.
	@available(iOS 10.0, *)
	func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
		print("userNotificationCenter:didReceiveWithCompletion")
		completionHandler()
		// works for iOS10 i.e. called when clicked, not when received.....
		//  Here would be where we go to chat screen.....
	}
	
	
	//************************************************************************************************************************************************************//
	//MARK: - Handle Notification
	//************************************************************************************************************************************************************//
	
	
	func handleNotification(userInfo: [AnyHashable: Any], handler: () -> Void) {
		// If you are receiving a notification message while your app is in the background,
		// this callback will not be fired till the user taps on the notification launching the application.
		
		print("handleNotification")
		// Print full message.
		//        print("\(userInfo)")
		
		// Print message ID.
		if let messageId = userInfo["gcm.message_id"] {
			print("Message ID: \(messageId)")
		}
		
		// Let FCM know about the message for analytics etc.
		Messaging.messaging().appDidReceiveMessage(userInfo)
		
		if UIApplication.shared.applicationState == UIApplicationState.active {
			// App is running in foreground, show alert
			
			if let aps = userInfo["aps"] as? [AnyHashable: Any], let alert = aps["alert"] as? [AnyHashable: Any], let title = alert["title"] as? String, let body = alert["body"] as? String {
				displayAlert(title, message: body)
			}
		}
		
		// Invoke the completion handler passing the appropriate UIBackgroundFetchResult value
		// [START_EXCLUDE]
		handler()
		// [END_EXCLUDE]
	}
	
	//Called when a notification is delivered to a foreground app.
	private func displayAlert(_ title: String, message: String?) {
		if let alertText = message {
			let alertController = UIAlertController(title: title, message: alertText, preferredStyle: UIAlertControllerStyle.alert)

			let OKAction = UIAlertAction(title: NSLocalizedString("ok", comment: "Close button"), style: .default) { (action) in
			}
			
			alertController.addAction(OKAction)

			DispatchQueue.main.async(execute: {
				UIApplication.shared.keyWindow!.rootViewController?.present(alertController, animated: true, completion: nil)
			})
		}
	}
	
	private func displayAlertAsLocalNotification(_ title: String, message: String?, userInfo: [AnyHashable: Any]) {
		if let alertText = message {
			let localNotification: UILocalNotification = UILocalNotification()
			localNotification.fireDate = Date()
			localNotification.timeZone = TimeZone.current
			if #available(iOS 8.2, *) {
				localNotification.alertTitle = title
				localNotification.alertBody = alertText
			}
			else {
				// Fallback on earlier versions
				localNotification.alertBody = String(format: NSLocalizedString("notification_title_and_body", comment: "Title+Body"), arguments: [title, alertText])
			}
			localNotification.alertAction = "View"
			localNotification.soundName = UILocalNotificationDefaultSoundName
			localNotification.userInfo = userInfo
			
			UIApplication.shared.scheduleLocalNotification(localNotification)
		}
		
	}
	func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
		//TODO: pretty sure this is a mispelling and will never fire
		print("TESTLOG:didReceiveRemoteNotification")
		
		//        /Let FCM know about the message for analytics etc.
		//        Messaging.messaging().appDidReceiveMessage(userInfo)
		//        handle your message
	}
	
	//    // iOS 10 +
	//    // Called when notification opened outside/inside app
	//    // It's the Firebase direct channel method
	public func application(received remoteMessage: MessagingRemoteMessage) {
		//TODO: Never called
		print("TESTLOG:DirectChannel  received remoteMessage")
	}
	
}

