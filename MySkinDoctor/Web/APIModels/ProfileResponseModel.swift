//
//  ProfileResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex on 21/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class ProfileResponseModel : BaseResponseModel {
	
	var addressLine1: String?
	var addressLine2: String?
	var dob: Date?
	var gpAddress: String?
	var gpContactPermission: Bool = false
	var gpName: String?
	var gpPostcode: String?
	var accessCodes: [AccessCodeResponseModel] = []
	var firstName: String?
	var lastName: String?
	var mobileNumber: String?
	var postcode: String?
	var town: String?
	var selfPay: Bool = false
	var credits: String?
	var profileImageUrl: String?
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		if let dateString = map["date_of_birth"].currentValue as? String, let _date = dateString.dateFromISO8601WithoutTime { dob = _date }
	
		addressLine1 <- map["address_line_1"]
		addressLine2 <- map["address_line_2"]
		firstName <- map["first_name"]
		gpAddress <- map["gp_address"]
		gpContactPermission <- map["gp_contact_permission"]
		gpName <- map["gp_name"]
		gpPostcode <- map["gp_postcode"]
		lastName <- map["last_name"]
		mobileNumber <- map["mobile_number"]
		postcode <- map["postcode"]
		accessCodes <- map["access_codes"]
		town <- map["town"]
		selfPay <- map["self_pay"]
		credits <- map["credits"]
		profileImageUrl <- map["profile_image_url"]
	}
}

