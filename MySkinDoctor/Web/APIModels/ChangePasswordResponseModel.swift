//
//  ChangePasswordResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex on 16/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class ChangePasswordResponseModel : BaseResponseModel {
	
	var detail: [String] = []
	
	// Mappable
	override func mapping(map: Map) {
		detail <- map["detail"]
	}
	
}
