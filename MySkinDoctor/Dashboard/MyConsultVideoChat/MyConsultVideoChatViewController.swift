//
//  MyConsultVideoChatViewController.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 05/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import OpenTok

class MyConsultVideoChatViewController: BindingViewController {
	
	@IBOutlet weak var videoView: UIView!
	@IBOutlet weak var expertActivityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var selfieView: UIView!
	@IBOutlet weak var userActivityIndicator: UIActivityIndicatorView!
	@IBOutlet weak var endSessionButton: PositiveButton!
	@IBOutlet weak var videoButton: UIBarButtonItem!
	@IBOutlet weak var audioButton: UIBarButtonItem!
	
	var session : OTSession?
	var publisher : OTPublisher?
	var subscriber : OTSubscriber?
	
	var viewModelCast: MyConsultVideoChatViewModel!
	
	override func initViewModel(viewModel: BaseViewModel) {
		super.initViewModel(viewModel: viewModel)
		
		viewModelCast = viewModel as! MyConsultVideoChatViewModel
		
		viewModelCast.videoIconUpdated = { [weak self] (isVideoOn) in
			DispatchQueue.main.async {
				self?.videoButton.image = self?.viewModelCast.videoImage
			}
		}
		
		viewModelCast.audioIconUpdated = { [weak self] (isAudioOn) in
			DispatchQueue.main.async {
				self?.audioButton.image = self?.viewModelCast.audioImage
			}
		}
		
		viewModelCast.videoIsEnabledUpdated = { [weak self] (isVideoEnabled) in
			DispatchQueue.main.async {
				self?.videoButton.isEnabled = isVideoEnabled
			}
		}
		
		viewModelCast.audioIsEnabledUpdated = { [weak self] (isAudioEnabled) in
			DispatchQueue.main.async {
				self?.audioButton.isEnabled = isAudioEnabled
			}
		}
		
		viewModelCast.updateLoadingStatus = { [weak self] () in
			DispatchQueue.main.async {
				if (self?.viewModelCast.isLoading)! {
					self?.expertActivityIndicator.startAnimating()
					self?.userActivityIndicator.startAnimating()
				} else {
					self?.expertActivityIndicator.stopAnimating()
					self?.userActivityIndicator.stopAnimating()
				}
			}
		}
		
		viewModelCast.onGetVideoChatSessionFinished = { [weak self] (successful) in
			DispatchQueue.main.async {
				if successful {
					self?.startSession()
				}
			}
		}
	}
		
	override func viewDidLoad() {
		super.viewDidLoad()

		// Detect changes in orientation
		UIDevice.current.beginGeneratingDeviceOrientationNotifications()
		NotificationCenter.default.addObserver(self, selector: #selector(onOrientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
		
		videoButton.target = self
		videoButton.action = #selector(onClickVideoToggleButton)
		
		audioButton.target = self
		audioButton.action = #selector(onClickAudioToggleButton)
		
		viewModelCast.disableToggleOptions()
	}
		
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		
		// End orientation change notifications
		NotificationCenter.default.removeObserver(self)
		if UIDevice.current.isGeneratingDeviceOrientationNotifications {
			UIDevice.current.endGeneratingDeviceOrientationNotifications()
		}
		
		// End timer
		viewModelCast.disableTimer()
		
		// Disconnect from session
		if let session = self.session, session.sessionConnectionStatus == OTSessionConnectionStatus.connected {
			var maybeError : OTError?
			self.session?.disconnect(&maybeError)
		}
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		UIApplication.shared.isIdleTimerDisabled = false
	}
	
	func applyTheme() {
		
	}
	
	func applyLocalization() {
		title = NSLocalizedString("consultation", comment: "Consultation")
		endSessionButton.setTitle(NSLocalizedString("end_video_chat", comment: "End call").uppercased(), for: UIControlState())

	}
	
	// MARK: IBActions
	
	@IBAction func onClickVideoToggleButton(_ sender: AnyObject) {
		if let pub = publisher {
			if viewModelCast.isVideoEnabled {
				// Disable
				pub.publishVideo = false
				viewModelCast.isVideoOn = false
			}
			else {
				// Enable
				pub.publishVideo = true
				viewModelCast.isVideoOn = true
			}
		}
	}
	
	@IBAction func onClickAudioToggleButton(_ sender: AnyObject) {
		if let pub = publisher {
			if viewModelCast.isAudioEnabled {
				// Disable
				pub.publishAudio = false
				viewModelCast.isAudioOn = false
			}
			else {
				// Enable
				pub.publishAudio = true
				viewModelCast.isAudioOn = true
			}
		}
	}
	
	
	// MARK: Helpers
	
	func disableToggleOptions() {
		viewModelCast.disableToggleOptions()
	}
	
	func enableToggleOptions() {
		viewModelCast.enableToggleOptions()
	}
	
	func startSession() {
		// Step 1: As the view is loaded initialize a new instance of OTSession
		if viewModelCast.isValidEventSession {
			session = OTSession(apiKey: viewModelCast.apiKey, sessionId: viewModelCast.opentokSessionId, delegate: self)
			
			// Keep screen on
			UIApplication.shared.isIdleTimerDisabled = true
			
			viewModelCast.sessionStartTime = Date()
			
			viewModelCast.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(endSessionIfExpired), userInfo: nil, repeats: true)
			
			// Step 2: As the view comes into the foreground, begin the connection process.
			if viewModelCast.isConsultationTime() {
				doConnect()
			}
		} else {
			showAlertView(title: NSLocalizedString("video_chat_connection_error_title", comment: "Session ended"), message: NSLocalizedString("video_chat_connection_error_message", comment: "Your session has now ended."), handler: { (alert) in
				self.navigationController?.popViewController(animated: true)
			})
		}
	}
	
	@objc func endSessionIfExpired() {
		if !viewModelCast.isConsultationTime() {			
			// End timer
			viewModelCast.disableTimer()
			
			// Disconnect from session
			if let session = self.session, session.sessionConnectionStatus == OTSessionConnectionStatus.connected {
				var maybeError : OTError?
				self.session?.disconnect(&maybeError)
			}
			
			showAlertView(title: NSLocalizedString("session_ended_title", comment: "Session ended"), message: NSLocalizedString("session_ended_message", comment: "Your session has now ended."), handler: { (alert) in
				self.navigationController?.popViewController(animated: true)
			})
		}
	}
	
	@objc func onOrientationChanged(_ notification: Notification) {
		// Resize video view
		if let otPublisher = publisher {
			if let size = getPublisherViewSize() {
				otPublisher.view?.frame = size
			}
		}
		if let otSubscriber = subscriber {
			if let size = getSubscriberViewSize() {
				otSubscriber.view?.frame = size
			}
		}
	}
	
}


extension MyConsultVideoChatViewController: OTSessionDelegate, OTSubscriberKitDelegate, OTPublisherDelegate {
	
	// MARK: - OpenTok Methods
	
	/**
	* Asynchronously begins the session connect process. Some time later, we will
	* expect a delegate method to call us back with the results of this action.
	*/
	func doConnect() {
		if let session = self.session {
			var maybeError : OTError?
			session.connect(withToken: viewModelCast.opentokToken, error: &maybeError)
			if let error = maybeError {
				showAlertView(title: "error", message: error.localizedDescription)
			}
		}
	}
	
	/**
	* Sets up an instance of OTPublisher to use with this session. OTPubilsher
	* binds to the device camera and microphone, and will provide A/V streams
	* to the OpenTok session.
	*/
	func doPublish() {
		publisher = OTPublisher(delegate: self)
		
		if let session = self.session {
			var maybeError : OTError?
			session.publish(publisher!, error: &maybeError)
			
			if let error = maybeError {
				showAlertView(title: "error", message: error.localizedDescription)
			}
			
			publisher!.view?.frame = CGRect(x: 0.0, y: 0.0, width: selfieView.frame.width, height: selfieView.frame.height)
			if let size = getPublisherViewSize() {
				publisher!.view?.frame = size
			}
			selfieView.addSubview(publisher!.view!)
		}
	}
	
	/**
	* Cleans up the publisher and its view. At this point, the publisher should not
	* be attached to the session any more.
	*/
	func cleanUpPublisher() {
		if let pub = publisher {
			pub.view?.removeFromSuperview()
			self.publisher = nil
		}
		// this is a good place to notify the end-user that publishing has stopped.
	}
	
	/**
	* Instantiates a subscriber for the given stream and asynchronously begins the
	* process to begin receiving A/V content for this stream. Unlike doPublish,
	* this method does not add the subscriber to the view hierarchy. Instead, we
	* add the subscriber only after it has connected and begins receiving data.
	*/
	func doSubscribe(_ stream : OTStream) {
		if let session = self.session {
			subscriber = OTSubscriber(stream: stream, delegate: self)
			
			var maybeError : OTError?
			session.subscribe(subscriber!, error: &maybeError)
			if let error = maybeError {
				showAlertView(title: "", message: error.localizedDescription)
			}
		}
	}
	
	/**
	* Cleans the subscriber from the view hierarchy, if any.
	* NB: You do *not* have to call unsubscribe in your controller in response to
	* a streamDestroyed event. Any subscribers (or the publisher) for a stream will
	* be automatically removed from the session during cleanup of the stream.
	*/
	func cleanUpSubscriber() {
		if let sub = subscriber {
			sub.view?.removeFromSuperview()
			self.subscriber = nil
		}
	}
	
	// MARK: - OTSession delegate callbacks
	
	func sessionDidConnect(_ session: OTSession) {
		print("sessionDidConnect (\(session.sessionId))")
		
		// Step 2: We have successfully connected, now instantiate a publisher and
		// begin pushing A/V streams into OpenTok.
		doPublish()
	}
	
	func sessionDidDisconnect(_ session : OTSession) {
		print("Session disconnected (\( session.sessionId))")
	}
	
	func session(_ session: OTSession, streamCreated stream: OTStream) {
		print("session streamCreated (\(stream.streamId))")
		
		//        // Step 3a: (if NO == subscribeToSelf): Begin subscribing to a stream we
		//        // have seen on the OpenTok session.
		//        if subscriber == nil && !subscribeToSelf {
		//            doSubscribe(stream)
		//        }
		
		if (stream.connection.connectionId == session.connection?.connectionId) {
			// This is my own stream
		}
		else {
			// This is a stream from another client
			doSubscribe(stream)
		}
	}
	
	func session(_ session: OTSession, streamDestroyed stream: OTStream) {
		print("session streamCreated (\(stream.streamId))")
		
		if (subscriber?.stream?.streamId)! == stream.streamId {
			cleanUpSubscriber()
		}
	}
	
	func session(_ session: OTSession, connectionCreated connection : OTConnection) {
		print("session connectionCreated (\(connection.connectionId))")
	}
	
	func session(_ session: OTSession, connectionDestroyed connection : OTConnection) {
		print("session connectionDestroyed (\(connection.connectionId))")
		
		if (subscriber?.stream?.connection.connectionId)! == connection.connectionId {
			cleanUpSubscriber()
		}
	}
	
	func session(_ session: OTSession, didFailWithError error: OTError) {
		print("session didFailWithError (%@)", error)
	}
	
	// MARK: - OTSubscriber delegate callbacks
	
	func getSubscriberViewSize() -> CGRect? {
		switch (UIDevice.current.orientation) {
		case .portrait, .portraitUpsideDown:
			let width = videoView.frame.width
			let height = (width / 4.0) * 3.0
			let offset = (videoView.frame.height - height) / 2.0
			return CGRect(x: 0.0, y: offset, width: width, height: height)
			
		case .landscapeLeft, .landscapeRight:
			return CGRect(x: 0.0, y: 0.0, width: videoView.frame.width, height: videoView.frame.height)
			
		default:
			return nil
		}
	}
	
	func subscriberDidConnect(toStream subscriberKit: OTSubscriberKit) {
		print("subscriberDidConnectToStream (\(subscriberKit))")
		
		if let sub: OTSubscriber = subscriberKit as? OTSubscriber {
			sub.view?.frame = CGRect(x: 0.0, y: 0.0, width: videoView.frame.width, height: videoView.frame.height)
			if let size = getSubscriberViewSize() {
				sub.view?.frame = size
			}
			self.videoView.addSubview(sub.view!)
		}
	}
	
	func subscriber(_ subscriber: OTSubscriberKit, didFailWithError error : OTError) {
		print("subscriber %@ didFailWithError %@", subscriber.stream?.streamId ?? "-", error)
	}
	
	// MARK: - OTPublisher delegate callbacks
	
	func getPublisherViewSize() -> CGRect? {
		switch (UIDevice.current.orientation) {
		case .portrait, .portraitUpsideDown:
			let width = selfieView.frame.width
			let height = (width / 4.0) * 3.0
			return CGRect(x: 0.0, y: 0.0, width: width, height: height)
			
		case .landscapeLeft, .landscapeRight:
			let height = selfieView.frame.height
			let width = (height / 3.0) * 4.0
			return CGRect(x: 0.0, y: 0.0, width: width, height: height)
			
		default:
			return nil
		}
	}
	
	func publisher(_ publisher: OTPublisherKit, streamCreated stream: OTStream) {
		print("publisher streamCreated %@", stream)
		
		enableToggleOptions()
		
		//        // Step 3b: (if YES == subscribeToSelf): Our own publisher is now visible to
		//        // all participants in the OpenTok session. We will attempt to subscribe to
		//        // our own stream. Expect to see a slight delay in the subscriber video and
		//        // an echo of the audio coming from the device microphone.
		//        if subscriber == nil && subscribeToSelf {
		//            doSubscribe(stream)
		//        }
	}
	
	func publisher(_ publisher: OTPublisherKit, streamDestroyed stream: OTStream) {
		print("publisher streamDestroyed %@", stream)
		
		disableToggleOptions()
		cleanUpSubscriber()
		cleanUpPublisher()
	}
	
	func publisher(_ publisher: OTPublisherKit, didFailWithError error: OTError) {
		NSLog("publisher didFailWithError %@", error)
		
		disableToggleOptions()
	}
	
}
