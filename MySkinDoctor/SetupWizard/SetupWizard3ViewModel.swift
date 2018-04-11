//
//  SetupWizard3ViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class SetupWizard3ViewModel: BaseViewModel {
	
	var profile: Profile!
	
	var gpName = ""
	var accessCode = ""
	var gpAddressLine = ""
	var gpPostcode = ""
	var isPermisionEnabled = false
	
	var isAccessCodeHidden: Bool {
		get {
			return !profile.isNHS
		}
	}
	
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
		
		gpName = profile.gpName ?? ""
		gpAddressLine = profile.gpAddressLine ?? ""
		gpPostcode = profile.gpPostcode ?? ""
		accessCode = profile.accessCode ?? ""
		isPermisionEnabled = profile.isPermisionEnabled
	}
	
	override func saveModel() {
		super.saveModel()
		
		if accessCode != self.profile.accessCode && !accessCode.isEmpty{
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
		ApiUtils.updateProfile(accessToken: DataController.getAccessToken(), firstName: nil, lastName: nil, dob: nil, phone: nil, addressLine1: nil, addressLine2: nil, town: nil, postcode: nil, gpName: gpName, gpAddress: gpAddressLine, gpPostCode: gpPostcode, gpContactPermission: isPermisionEnabled, selfPay: nil, completionHandler: { (result) in
			self.isLoading = false
			
			switch result {
			case .success(_):
				print("update profile success")
				
				let profile = DataController.createUniqueEntity(type: Profile.self)
				profile.gpName = self.gpName
				profile.accessCode = self.accessCode
				profile.gpAddressLine = self.gpAddressLine
				profile.gpPostcode = self.gpPostcode
				profile.isPermisionEnabled = self.isPermisionEnabled
				
				DataController.saveEntity(managedObject: profile)
				
				self.goNextSegue!()
				
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		})
		
	}
}
