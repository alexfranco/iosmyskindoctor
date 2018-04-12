//
//  LocalNotifications.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 12/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class LocalNotifications {
	
	// MARK: Local notifications
	
	fileprivate class func getAllEventNotifications(_ eventId: Int) -> [UILocalNotification] {
		var notifications: [UILocalNotification] = []
		let app: UIApplication = UIApplication.shared
		if let scheduledNotifications = app.scheduledLocalNotifications {
			for oneEvent in scheduledNotifications {
				let notification = oneEvent as UILocalNotification
				let userInfoCurrent = notification.userInfo! as! [String: AnyObject]
				if let id = userInfoCurrent["event_id"] as? Int, id == eventId {
					notifications.append(notification)
				}
			}
		}
		return notifications
	}
	
	class func createAllEventNotifications(_ eventId: Int, eventStart: Date, expertName: String, firstReminderMinutes: Int, secondReminderMinutes: Int) {
		// Clear all notifications for this event
		deleteAllEventNotifications(eventId)
		
		// Only create notifications for upcoming events
		if eventStart > Date() {
			createEventNotification(eventId, eventStart: eventStart, expertName: expertName, reminderMinutes: firstReminderMinutes)
			createEventNotification(eventId, eventStart: eventStart, expertName: expertName, reminderMinutes: secondReminderMinutes)
		}
	}
	
	fileprivate class func createEventNotification(_ eventId: Int, eventStart: Date, expertName: String, reminderMinutes: Int) {

		let eventTime = eventStart.adjust(.minute, offset: reminderMinutes)
		
		if eventTime < Date() {
			return
		}
		
		let localNotification: UILocalNotification = UILocalNotification.init()
		localNotification.fireDate = eventTime
		if (reminderMinutes == 0) {
			localNotification.alertBody = String(format: NSLocalizedString("alert_upcoming_appointment_starting", comment: "Reminder for appointment starting"), arguments: [expertName])
		}
		else {
			localNotification.alertBody = String(format: NSLocalizedString("alert_upcoming_appointment", comment: "Reminder for upcoming appointment"), arguments: [expertName, (reminderMinutes * -1)])
		}
		localNotification.timeZone = TimeZone.current
		localNotification.userInfo = ["event_id": eventId, "reminder_time": localNotification.fireDate!]
		UIApplication.shared.scheduleLocalNotification(localNotification)
	}
	
	class func deleteAllEventNotifications(_ eventId: Int) {
		let notifications = getAllEventNotifications(eventId)
		for notification in notifications {
			UIApplication.shared.cancelLocalNotification(notification)
		}
	}
}
