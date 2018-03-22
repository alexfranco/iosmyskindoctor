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
	var gpAccessCode = ""
	var gpAddressLine = ""
	var gpPostcode = ""
	var isPermisionEnabled = true
	
	var profileImage: UIImage = UIImage(named: "logo")! {
		didSet {
			if profileImageUpdated != nil {
				profileImageUpdated!(profileImage)
			}
		}
	}
	
	var profileImageUpdated: ((_ image: UIImage)->())?
	
	var didSaveChanges: (()->())?
	
	override init() {
		super.init()
		
		loadDBModel()
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
				let modelCast = model as! ProfileResponseModel
				self.parseResponseModel(model: modelCast)
				self.loadDBModel()
				
				self.onFetchFinished!()
				
			case .failure(let model, let error):
				print("error \(error.localizedDescription)")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		}
	}
	
	override func parseResponseModel(model: ProfileResponseModel) {
		super.parseResponseModel(model: model)
		
		let profile = DataController.createUniqueEntity(type: Profile.self)
		
		profile.firstName = model.firstName
		profile.lastName = model.lastName
		
		profile.phone = model.mobileNumber
		profile.postcode = model.postcode
		profile.town = model.town
		profile.gpName = model.gpName
		profile.gpAddressLine = model.gpAddress
		profile.gpPostcode = model.gpPostcode
		profile.isNHS = model.selfPay ?? false
		
		if let dobSafe = model.dob as NSDate? { profile.dob = dobSafe }
		
		DataController.saveEntity(managedObject: profile)
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
		gpAccessCode = profile.gpAccessCode ?? ""
		gpAddressLine = profile.gpAddressLine ?? ""
		gpPostcode = profile.gpPostcode ?? ""
		isPermisionEnabled = profile.isPermisionEnabled
		
		if let profileImageSafe = profile.profileImage as? UIImage {
			profileImage = profileImageSafe
		} else {
			profileImage = UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!
		}
	}
	
	override func saveModel() {
		super.saveModel()
		
		ApiUtils.updateProfile(accessToken: DataController.getAccessToken(), firstName: firstName, lastName: lastName, dob: dob, phone: phone, addressLine1: addressLine1, addressLine2: addressLine2, town: town, postcode: postcode, gpName: gpName, gpAddress: gpAddressLine, gpPostCode: gpPostcode, gpContactPermission: isPermisionEnabled, selfPay: nil, completionHandler: { (result) in
			self.isLoading = false
			
			switch result {
			case .success(_):
				print("update profile success")
				
				self.profile.firstName = self.firstName
				self.profile.lastName = self.lastName
				
				self.profile.phone = self.phone
				
				if let dobSafe = self.dob as NSDate? {
					self.profile.dob = dobSafe
				}
				
				self.profile.addressLine1 = self.addressLine1
				self.profile.addressLine2 = self.addressLine2
				self.profile.town = self.town
				self.profile.postcode = self.postcode
				self.profile.gpName = self.gpName
				self.profile.gpAccessCode = self.gpAccessCode
				self.profile.gpAddressLine = self.gpAddressLine
				self.profile.gpPostcode = self.gpPostcode
				self.profile.isPermisionEnabled = self.isPermisionEnabled
				self.profile.profileImage = self.profileImage
				
				DataController.saveEntity(managedObject: self.profile)
				
				self.didSaveChanges!()
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		})
	}
}
