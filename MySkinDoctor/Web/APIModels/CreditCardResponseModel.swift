//
//  CreditCardResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class CreditCardResponseModel: BaseResponseModel {
	
	var id: Int?
	var siteId: Int?
	var summary: String?
	var credits: String?
	var dateCreated: Date?

	// Value calculated from dateCreated
	var dateCreatedTimestamp: Date?

	required init?(map: Map) {
		super.init(map: map)
	}

	// Mappable
	override func mapping(map: Map) {
		id <- map["id"]
		siteId <- map["site_id"]
		summary <- map["summary"]
		credits <- map["credits"]
		
		if let dateString = map["date_created"].currentValue as? String, let _date = dateString.dateFromISO8601WithoutTime { dateCreated = _date }
	}
}
