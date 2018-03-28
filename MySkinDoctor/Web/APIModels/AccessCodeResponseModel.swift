//
//  AccessCodeResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex on 28/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class AccessCodeResponseModel: BaseResponseModel {
	
	var code: String?
	var dateUsed: Date?
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		if let dateString = map["date_used"].currentValue as? String, let _date = dateString.dateFromISO8601 { dateUsed = _date }
		code <- map["code"]
	}
}
