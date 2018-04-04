//
//  CreditOptionsResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class CreditOptionsResponseModel: Mappable {
	
	var id: Int?
	var amount: String?
	var currency: String?
	var credits: String?
	
	required init?(map: Map) {
	}
	
	// Mappable
	func mapping(map: Map) {
		id <- map["option_id"]
		amount <- map["amount"]
		currency <- map["currency"]
		credits <- map["credits"]
	}
}
