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
	
	private (set) var model: Consultation!
	private (set) var eventSession: EventSessionResponseModel?
	
	var timer: Timer?
	var sessionStartTime: Date?
	var sessionEndTime: Date?
	
	// Bind properties
	var videoIconUpdated: ((_ isVideoOn: Bool)->())?
	var audioIconUpdated: ((_ isAudioOn: Bool)->())?

	var videoIsEnabledUpdated: ((_ isVideoEnabled: Bool)->())?
	var audioIsEnabledUpdated: ((_ isAudioEnabled: Bool)->())?
	
	var onGetVideoChatSessionFinished: ((_ successful: Bool)->())?
	
	var isValidEventSession: Bool {
		get {
			guard let eventSessionSafe = eventSession else {
				return false
			}
			
			return eventSessionSafe.apiKey != nil && eventSessionSafe.opentokSessionId != nil && eventSessionSafe.opentokToken != nil
		}
	}
	
	var apiKey: String {
		get {
			guard let eventSessionSafe = eventSession else {
				return ""
			}
			
			return eventSessionSafe.apiKey ?? ""
		}
	}
	
	var opentokToken: String {
		get {
			guard let eventSessionSafe = eventSession else {
				return ""
			}
			
			return eventSessionSafe.opentokToken ?? ""
		}
	}
	
	var opentokSessionId: String {
		get {
			guard let eventSessionSafe = eventSession else {
				return ""
			}
			
			return eventSessionSafe.opentokSessionId ?? ""
		}
	}
	
	var isVideoOn: Bool = false {
		didSet {
			videoIconUpdated!(isVideoOn)
		}
	}
	
	var isAudioOn: Bool = false {
		didSet {
			audioIconUpdated!(isAudioOn)
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
			return (isVideoOn ? UIImage(named: "videoChatVideocamOn") : UIImage(named: "videoChatVideocamOff"))!
		}
	}
	
	var audioImage: UIImage {
		get {
			return (isAudioOn ? UIImage(named: "videoChatVolumeOn") : UIImage(named: "videoChatVolumeOff"))!
		}
	}
	
	required init(model: Consultation) {
		super.init()
		self.model = model
		
		fetchInternetModel()
	}
	
	override func fetchInternetModel() {
		super.fetchInternetModel()
		
		isLoading = true
		
		ApiUtils.getVideoChatSession(accessToken: DataController.getAccessToken(), skinProblemsId: Int(self.model.skinProblems!.skinProblemId), eventId: Int(model.appointmentId)) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("get startSessionAppointment")
				self.eventSession = model as? EventSessionResponseModel
				self.onGetVideoChatSessionFinished!(true)
			case .failure(let model, let error):
				print("error \(error.localizedDescription)")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
				self.onGetVideoChatSessionFinished!(false)
			}
		}
	}
	
	func isConsultationTime() -> Bool {
		return model.isConsultationTime()
	}
	
	func isBeforeConsultation() -> Bool {
		return model.isBeforeConsultation()
	}
	
	func enableToggleOptions() {
		isAudioEnabled = true
		isVideoEnabled = true
		isVideoOn = true
		isAudioOn = true
	}
	
	func disableToggleOptions() {
		isAudioEnabled = false
		isVideoEnabled = false
		isVideoOn = false
		isAudioOn = false
	}
	
	func disableTimer() {
		timer?.invalidate()
		timer = nil
	}
}
