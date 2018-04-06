//
//  SubmittedSkinProblemsResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 10/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class SubmittedSkinProblemsResponseModel : BaseResponseModel {
	
	var skinProblems: SkinProblemsResponseModel?
	var transation: TransationResponseModel?
	
	required init?(map: Map) {
		super.init(map: map)
	}
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		skinProblems <- map["case"]
		transation <- map["transaction"]
	}
}

class TransationResponseModel : BaseResponseModel {
	
	var credits: String?
	var dateCreated: Date?
	var summary: String?
	
	required init?(map: Map) {
		super.init(map: map)
	}
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		credits <- map["credits"]
		summary <- map["summary"]
		
		if let dateString = map["date_created"].currentValue as? String, let _date = Formatter.iso8601.date(from: dateString) { dateCreated = _date }
	}
}
