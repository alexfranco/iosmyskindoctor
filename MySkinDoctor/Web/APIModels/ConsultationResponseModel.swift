//
//  ConsultationResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 10/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class ConsultationResponseModel : BaseResponseModel {
	
	var event: EventResponseModel?
	var transation: TransationResponseModel?
	
	required init?(map: Map) {
		super.init(map: map)
	}
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		event <- map["event"]
		transation <- map["transaction"]
	}
}

class EventResponseModel : BaseResponseModel {
	
	var start: Date?
	var cancelled: Bool = false
	var eventId: Int = 0
	var caseId: Int = 0
	var duration: Int = 0
	
	
	required init?(map: Map) {
		super.init(map: map)
	}
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		eventId <- map["id"]
		caseId <- map["case_id"]
		duration <- map["duration"]
		cancelled <- map["cancelled"]
		if let dateString = map["start"].currentValue as? String, let _date = Formatter.iso8601.date(from: dateString) { start = _date }
	}
}


