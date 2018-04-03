//
//  DiagnoseAttachmentResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 03/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class DiagnoseAttachmentResponseModel: BaseResponseModel {
	
	var diagnoseResourceName: String?
	var url: String?
	var diagnoseResourceId: Int = 0
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		diagnoseResourceName <- map["name"]
		url <- map["file_url"]
		diagnoseResourceId <- map["id"]
	}
}
