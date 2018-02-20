//
//  ForgotPasswordResposeModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 20/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class ForgotPasswordResposeModel : BaseResponseModel {
	
	var emailErrors: [String] = []
	
	// Mappable
	override func mapping(map: Map) {
		emailErrors <- map["email"]
	}
	
}
