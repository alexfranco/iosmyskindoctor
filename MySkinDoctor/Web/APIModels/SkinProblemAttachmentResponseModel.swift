//
//  SkinProblemsAttachmentResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex on 23/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class SkinProblemAttachmentResponseModel : BaseResponseModel {
	
	var problemDescription: String?
	var filename: String?
	var attachmentType: Int = 0
	var location: Int = 0
	var problemImage: NSObject?
	var url: String?
	var skinProblemAttachmentId: Int = 0
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		problemDescription <- map["description"]
		filename <- map["file_name"]
		attachmentType <- map["photo_type"]
		location <- map["photo_location"]
		skinProblemAttachmentId <- map["id"]
	}
}
