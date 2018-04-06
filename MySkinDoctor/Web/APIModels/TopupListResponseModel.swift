//
//  TopupListResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class TopupListResponseModel: Mappable {
	var options: [CreditOptionsResponseModel] = []
	var stripe: StripeResponseModel?
	
	required init?(map: Map) {
	}
	
	// Mappable
	func mapping(map: Map) {
		options <- map["options"]
		stripe <- map["stripe"]
	}
}

class StripeResponseModel: Mappable {
	var apiKey: String?
	
	required init?(map: Map) {
	}
	
	// Mappable
	func mapping(map: Map) {
		apiKey <- map["api_key"]
	}
}

class CreditOptionsResponseModel: Mappable {
	
	var id: Int?
	var amount: String?
	var credits: String?
	var currency: String?
	
	required init?(map: Map) {
	}
	
	// Mappable
	func mapping(map: Map) {
		id <- map["id"]
		amount <- map["amount"]
		credits <- map["credits"]
		currency <- map["currency"]
	}
}
