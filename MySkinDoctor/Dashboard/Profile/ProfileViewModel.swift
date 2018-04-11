//
//  ProfileViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 26/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewModel: BaseViewModel {
	
	var profile: Profile!
	
	var name: String {
		get {
			if let firstName = profile.firstName, let lastName = profile.lastName {
				return firstName + " " + lastName
			} else {
				return "-"
			}
		}
	}
	
	var firstName = ""
	var lastName = ""
	var email = ""
	var phone = ""
	
	var dob: Date? {
		didSet {
			if dobUpdated != nil {
				dobUpdated!(dobDisplayText)
			}
		}
	}
	
	var dobUpdated: ((_ date: String)->())?

	var dobDisplayText: String {
		if dob == nil {
			return ""
		} else {
			let formatter = DateFormatter()
			formatter.dateFormat = "dd/MM/yyyy"
			return formatter.string(from: dob!)
		}
	}
	
	var addressLine1 = ""
	var addressLine2 = ""
	var town = ""
	var postcode = ""
	var gpName = ""
	var accessCode = ""
	var gpAddressLine = ""
	var gpPostcode = ""
	
	var isPermisionEnabled = true
	var profileImageUrl = ""
	
	private (set) var credits = "0"
	
	var isAccessCodeHidden: Bool {
		get {
			return !profile.isNHS
		}
	}
	
	var isWalletIconHidden: Bool {
		get {
			return profile.isNHS
		}
	}
	
	var didSaveChanges: (()->())?
	
	override init() {
		super.init()
		
		loadDBModel()
	}
	
	func refreshData() {
		fetchInternetModel()
	}
	
	override func fetchInternetModel() {
		super.fetchInternetModel()
		
		isLoading = true
		
		ApiUtils.getProfile(accessToken: DataController.getAccessToken()) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("get Profile")
				let _ = Profile.parseAndSaveProfileResponse(profileResponseModel: model as! ProfileResponseModel)
				self.loadDBModel()
				self.onFetchFinished!()
				
			case .failure(let model, let error):
				print("error \(error.localizedDescription)")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
	
	override func loadDBModel() {
		super.loadDBModel()
		
		profile = DataController.createUniqueEntity(type: Profile.self)
		
		firstName = profile.firstName ?? ""
		lastName = profile.lastName ?? ""
		
		email = profile.email ?? ""
		phone = profile.phone ?? ""
		
		if let dobSafe = profile.dob {
			dob = dobSafe as Date
		}
		
		addressLine1 = profile.addressLine1 ?? ""
		addressLine2 = profile.addressLine2 ?? ""
		town = profile.town ?? ""
		postcode = profile.postcode ?? ""
		gpName = profile.gpName ?? ""
		accessCode = profile.accessCode ?? ""
		gpAddressLine = profile.gpAddressLine ?? ""
		gpPostcode = profile.gpPostcode ?? ""
		isPermisionEnabled = profile.isPermisionEnabled		
		credits = profile.credits ?? "0"
		profileImageUrl = profile.profileImageUrl ?? ""
	}
	
	override func saveModel() {
		super.saveModel()
		
		if accessCode != self.profile.accessCode && !accessCode.isEmpty {
			self.isLoading = true

			createAccessCode { (success) in
				if success {
					self.updateProfile()
				} else {
					self.isLoading = false

					self.showAlert!("Access code", "Invalid Access Code")
				}
			}
		} else {
			self.isLoading = true
			self.updateProfile()
		}
	}
	
	private func createAccessCode(completionHandler: @escaping ((_ success: Bool) -> Void)) {
		
		ApiUtils.accessCode(accessToken: DataController.getAccessToken(), accesscode: accessCode, completionHandler: { (result) in
			
			switch result {
			case .success(_):
				print("accessCode")
				completionHandler(true)
			case .failure(_, _):
				print("error")
				completionHandler(false)
			}
		})
	}
	
	private func updateProfile() {
		
		ApiUtils.updateProfile(accessToken: DataController.getAccessToken(), firstName: firstName, lastName: lastName, dob: dob, phone: phone, addressLine1: addressLine1, addressLine2: addressLine2, town: town, postcode: postcode, gpName: gpName, gpAddress: gpAddressLine, gpPostCode: gpPostcode, gpContactPermission: isPermisionEnabled, selfPay: nil, completionHandler: { (result) in
			self.isLoading = false
			
			switch result {
			case .success(let model):
				print("update profile success")
				_ = Profile.parseAndSaveProfileResponse(profileResponseModel: model as! ProfileResponseModel)
				self.loadDBModel()
				self.onFetchFinished!()
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		})
	}

	func updateProfileImage(profileImage: UIImage) {
		let profileImageName = AWS3Utils.storeImage(image: profileImage)
		uploadToS3(imageName: profileImageName)
	}
	
	private func uploadToS3(imageName: String) {
		AWS3Utils.uploadImageToS3(filename: imageName) { (result) in
			switch result {
			case .success(let filename):
				print("uploadImageToS3 " + filename!)
				self.updateToServer(profileImageName: filename!)
			case .failure(let error):
				self.isLoading = false
				self.showResponseErrorAlert!(nil, error)
			}
		}
	}
	
	private func updateToServer(profileImageName: String) {
		ApiUtils.updateProfileImage(accessToken: DataController.getAccessToken(), profileImageFilename: profileImageName, completionHandler: { (result) in
			switch result {
			case .success(let model):
				print("updateProfileImage")
				_ = Profile.parseAndSaveProfileResponse(profileResponseModel: model as! ProfileResponseModel)
				self.loadDBModel()
				self.onFetchFinished!()
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		})
	}
	
	
}
