//
//  SetupWizard1ViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class SetupWizard1ViewModel: BaseViewModel {
	
	var profile: Profile!
	var firstName = ""
	var lastName = ""
	
	var dob: Date? {
		didSet {
			let formatter = DateFormatter()
			formatter.dateFormat = "dd/MM/yyyy"
			
			if dobUpdated != nil && dob != nil {
				dobUpdated!(formatter.string(from: dob!))
			}
		}
	}
	
	var dobDisplayText: String {
		if let dobSafe = dob {
			let formatter = DateFormatter()
			formatter.dateFormat = "dd/MM/yyyy"
			return formatter.string(from: dobSafe)
		} else {
			return ""
		}
	}
	
	var dobUpdated: ((_ date: String)->())?
	
	var phone = ""
	var postcode = ""
	
	override init() {
		super.init()
		self.loadDBModel()
		self.fetchInternetModel()
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
		
		phone = profile.phone ?? ""
		
		if let dobSafe = profile.dob {
			dob = dobSafe as Date
		}
		
		postcode = profile.postcode ?? ""
	}

	override func saveModel() {
		super.saveModel()
		
		ApiUtils.updateProfile(accessToken: DataController.getAccessToken(), firstName: firstName, lastName: lastName, dob: dob, phone: phone, addressLine1: nil, addressLine2: nil, town: nil, postcode: postcode, gpName: nil, gpAddress: nil, gpPostCode: nil, gpContactPermission: nil, selfPay: nil, completionHandler: { (result) in
			self.isLoading = false
			
			switch result {
			case .success(_):
				print("update profile success")
				
				let profile = DataController.createUniqueEntity(type: Profile.self)
				profile.firstName = self.firstName
				profile.lastName = self.lastName
				
				if let dobSafe = self.dob as NSDate? {
					profile.dob = dobSafe
				}
				
				profile.phone = self.phone
				profile.postcode = self.postcode
				DataController.saveEntity(managedObject: profile)
				
				self.goNextSegue!()
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		})
		
	}
}
