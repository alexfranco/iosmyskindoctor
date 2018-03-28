//
//  Profile+Extensions.swift
//  MySkinDoctor
//
//  Created by Alex on 28/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

extension Profile {
	
	static func parseAndSavProfileResponse(profileResponseModel: ProfileResponseModel) -> Profile {
		let profile = DataController.createUniqueEntity(type: Profile.self)
		
		profile.firstName = profileResponseModel.firstName
		profile.lastName = profileResponseModel.lastName
		
		profile.phone = profileResponseModel.mobileNumber
		profile.postcode = profileResponseModel.postcode
		profile.town = profileResponseModel.town
		profile.gpName = profileResponseModel.gpName
		profile.gpAddressLine = profileResponseModel.gpAddress
		profile.gpPostcode = profileResponseModel.gpPostcode
		profile.accessCode = profileResponseModel.accessCodes.first
		profile.isNHS = profileResponseModel.selfPay ?? false
		
		if let dobSafe = profileResponseModel.dob as NSDate? { profile.dob = dobSafe }
		
		DataController.saveEntity(managedObject: profile)
		
		return profile
	}
}
