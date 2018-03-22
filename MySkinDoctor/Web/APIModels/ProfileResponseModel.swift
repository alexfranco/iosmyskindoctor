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
	var firstName: String?
	var lastName: String?
	var mobileNumber: String?
	var postcode: String?
	var town: String?
	var selfPay: Bool?
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		let dateFormatter = DateFormatter()
		dateFormatter.date(from: "yyyy-MM-dd")
		
		if let dateString = map["date_of_birth"].currentValue as? String, let _date = dateFormatter.date(from: dateString) { dob = _date }
		
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
		town <- map["town"]
		selfPay <- map["selfPay"]
	}
	
}

