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
	
	var dob: Date = Date() {
		didSet {
			let formatter = DateFormatter()
			formatter.dateFormat = "dd/MM/yyyy"
			
			if dobUpdated != nil {
				dobUpdated!(formatter.string(from: dob))
			}
		}
	}
	
	var dobDisplayText: String {
		let formatter = DateFormatter()
		formatter.dateFormat = "dd/MM/yyyy"
		return formatter.string(from: dob)
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

	internal override func parseResponseModel(model: ProfileResponseModel) {
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
				profile.lastName = self.self.lastName
				profile.dob = self.dob as NSDate
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
