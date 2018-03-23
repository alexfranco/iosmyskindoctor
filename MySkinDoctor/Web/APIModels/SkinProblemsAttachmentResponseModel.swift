//
//  SkinProblemsAttachmentResponseModel.swift
//  MySkinDoctor
//
//  Created by Alex on 23/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import ObjectMapper

class SkinProblemsAttachmentResponseModel : BaseResponseModel {
	
	var problemDescription: String?
	var fileName: String?
	var attachmentType: SkinProblemAttachment.AttachmentType = SkinProblemAttachment.AttachmentType.photo
	var location: SkinProblemAttachment.LocationProblemType = SkinProblemAttachment.LocationProblemType
	
	// Mappable
	override func mapping(map: Map) {
		super .mapping(map: map)
		
		problemDescription <- map["description"]
		fileName <- map["file_name"]
		attachmentType <- map["photo_type"]
		location <- map["photo_location"]
	}
}
