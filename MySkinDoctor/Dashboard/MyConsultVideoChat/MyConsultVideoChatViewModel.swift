//
//  MyConsultVideoChatViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 05/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MyConsultVideoChatViewModel: BaseViewModel {
	
	var model: Consultation!
	
	var timer: Timer?
	var sessionStartTime: Date?
	var sessionEndTime: Date?
	
	// Bind properties
	var videoIconUpdated: ((_ isVideoOn: Bool)->())?
	var audioIconUpdated: ((_ isAudioOn: Bool)->())?

	var videoIsEnabledUpdated: ((_ isVideoEnabled: Bool)->())?
	var audioIsEnabledUpdated: ((_ isAudioEnabled: Bool)->())?
	
	var isVideoOn: Bool = false {
		didSet {
			videoIconUpdated!(isVideoEnabled)
		}
	}
	
	var isAudioOn: Bool = false {
		didSet {
			audioIconUpdated!(isAudioEnabled)
		}
	}
	
	var isVideoEnabled: Bool = false {
		didSet {
			videoIsEnabledUpdated!(isVideoEnabled)
		}
	}
	
	var isAudioEnabled: Bool = false {
		didSet {
			audioIsEnabledUpdated!(isAudioEnabled)
		}
	}
	
	var videoImage: UIImage {
		get {
			return (isVideoEnabled ? UIImage(named: "videoChatVideocamOn") : UIImage(named: "videoChatVideocamOff"))!
		}
	}
	
	var audioImage: UIImage {
		get {
			return (isAudioEnabled ? UIImage(named: "videoChatVolumeOn") : UIImage(named: "videoChatVolumeOff"))!
		}
	}
	
	required init(model: Consultation) {
		super.init()
		self.model = model
	}
	
	func isConsultationTime() -> Bool {
		let now = Date()
		if let appointmentDate = model.appointmentDate as Date? {
			return appointmentDate > now && appointmentDate < now.adjust(.hour, offset: 15)
		}
		return false
	}
	
	func isBeforeConsultation() -> Bool {
		let now = Date()
		if let appointmentDate = model.appointmentDate as Date? {
			return appointmentDate > now
		}
		return false
	}
	
	func enableToggleOptions() {
		isAudioEnabled = true
		isVideoEnabled = true
	}
	
	func disableToggleOptions() {
		isAudioEnabled = false
		isVideoEnabled = false
	}
	
	func disableTimer() {
		timer?.invalidate()
		timer = nil
	}
}
