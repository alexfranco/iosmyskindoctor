//
//  AppointmentsResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 10/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class AppointmentsResponseModel : BaseResponseModel {
	
	var start: Date?
	var end: Date?
	
	required init?(map: Map) {
		super.init(map: map)
	}
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		if let dateString = map["start"].currentValue as? String, let _date = Formatter.iso8601.date(from: dateString) { start = _date }
		
		if let dateString = map["end"].currentValue as? String, let _date = Formatter.iso8601.date(from: dateString) { end = _date }
	}
}
