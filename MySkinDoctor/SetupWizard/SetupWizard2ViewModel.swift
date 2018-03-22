//
//  SetupWizard2ViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 12/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation


class SetupWizard2ViewModel: BaseViewModel {
	
	var isNHS = false
	
	override init() {
		super.init()
	}
	
	override func saveModel() {
		super.saveModel()
		
		ApiUtils.updateProfile(accessToken: DataController.getAccessToken(), firstName: nil, lastName: nil, dob: nil, phone: nil, addressLine1: nil, addressLine2: nil, town: nil, postcode: nil, gpName: nil, gpAddress: nil, gpPostCode: nil, gpContactPermission: nil, selfPay: !isNHS, completionHandler: { (result) in
			self.isLoading = false
			
			switch result {
			case .success( _):
				print("update profile success")
				
				let profile = DataController.createUniqueEntity(type: Profile.self)
				profile.isNHS = self.isNHS
				DataController.saveEntity(managedObject: profile)
				
				self.goNextSegue!()
			case .failure(let model, let error):
				print("error")
				self.showResponseErrorAlert!(model as? BaseResponseModel, error)
			}
		})
		
	}
}
