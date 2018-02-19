//
//  RegistrationResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex on 16/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class RegistrationResponseModel : BaseResponseModel {
	
	var key: String?
	var emailErrors: [String] = []
		
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		key <- map["key"]
		emailErrors <- map["email"]
	}
	
}

