//
//  SkinProblemsAttachment+Extensions.swift
//  MySkinDoctor
//
//  Created by Alex on 23/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

extension SkinProblemAttachment {
	
	static func parseAndSaveSkinProblemsAttachmentResponse(attachment: SkinProblemAttachmentResponseModel) -> SkinProblemAttachment {
		let skinProblemAttachment = DataController.createOrUpdate(objectIdKey: "skinProblemAttachmentId", objectValue: attachment.skinProblemAttachmentId, type: SkinProblemAttachment.self)
		skinProblemAttachment.skinProblemAttachmentId = Int16(attachment.skinProblemAttachmentId)
		skinProblemAttachment.attachmentType = Int16(attachment.attachmentType)
		skinProblemAttachment.locationType = attachment.location ?? "none"
		skinProblemAttachment.url = attachment.url
		skinProblemAttachment.filename = attachment.filename
		skinProblemAttachment.problemImage = attachment.problemImage
		DataController.saveEntity(managedObject: skinProblemAttachment)
		
		return skinProblemAttachment
	}
}
