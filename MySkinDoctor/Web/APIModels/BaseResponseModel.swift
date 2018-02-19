//
//  BaseResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex on 19/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponseModel : Mappable {
	
	var nonFieldErrors: [String] = []
	var deviceIDErrors: [String] = []
	
	required init?(map: Map) {
	}
	
	// Mappable
	func mapping(map: Map) {	
		nonFieldErrors <- map["non_field_errors"]
		deviceIDErrors <- map["device_id"]
	}
	
}


