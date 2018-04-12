//
//  EventSessionResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 12/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class EventSessionResponseModel: BaseResponseModel {
	
	var eventId: Int = 0
	var opentokSessionId: String?
	var opentokToken: String?
	var apiKey: String?
	
	required init?(map: Map) {
		super.init(map: map)
	}
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		eventId <- map["id"]
		apiKey <- map["opentok_api_key"]
		opentokSessionId <- map["opentok_session_id"]
		opentokToken <- map["opentok_token"]
	}
}
