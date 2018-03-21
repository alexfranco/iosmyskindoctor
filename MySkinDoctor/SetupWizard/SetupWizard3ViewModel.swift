//
//  SetupWizard3ViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class SetupWizard3ViewModel: BaseViewModel {
	
	var gpName = ""
	var gpAccessCode = ""
	var gpAddressLine = ""
	var gpPostcode = ""
	var isPermisionEnabled = false
	
	override init() {		
		super.init()
	}
	
	func saveModel() {
		
		ApiUtils.updateProfile(accessToken: DataController.getAccessToken(), firstName: nil, lastName: nil, dob: nil, phone: nil, addressLine1: nil, addressLine2: nil, town: nil, postcode: nil, gpName: gpName, gpAddress: gpAddressLine, gpPostCode: gpPostcode, gpContactPermission: isPermisionEnabled, selfPay: nil, completionHandler: { (result) in
			self.isLoading = false
			
			switch result {
			case .success(_):
				print("update profile success")
				
				let profile = DataController.createUniqueEntity(type: Profile.self)
				profile.gpName = self.gpName
				profile.gpAccessCode = self.gpAccessCode
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
