//
//  DiagnoseAttachment+Extensions.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 03/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

extension DiagnoseAttachment {

	static func parseAndSave(attachmentResponse: DiagnoseAttachmentResponseModel) -> DiagnoseAttachment {
		let diagnoseAttachment = DataController.createOrUpdate(objectIdKey: "diagnosemAttachmentId", objectValue: attachmentResponse.diagnoseResourceId, type: DiagnoseAttachment.self)
		diagnoseAttachment.diagnosemAttachmentId = Int16(attachmentResponse.diagnoseResourceId)
		diagnoseAttachment.url = attachmentResponse.url
		diagnoseAttachment.diagnoseAttachmentName = attachmentResponse.diagnoseResourceName
		DataController.saveEntity(managedObject: diagnoseAttachment)
		
		return diagnoseAttachment
	}
}
