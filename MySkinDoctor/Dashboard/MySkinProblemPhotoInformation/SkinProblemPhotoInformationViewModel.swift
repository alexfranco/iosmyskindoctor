//
//  SkinProblemPhotoInformationViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 28/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemPhotoInformationViewModel: BaseViewModel {
	var model: SkinProblemAttachment!
	var problemDescription: String!
	var problemImage: UIImage!
	
	var goPhotoLocation: (()->())?
	var unwind: (()->())?
	
	required init(model: SkinProblemAttachment) {
		self.model = model
		self.problemDescription = model.problemDescription
		self.problemImage = model.problemImage == nil ? UIImage(named: "logo")! : model.problemImage as! UIImage
	}
	
	func saveModel(attachmentType: SkinProblemAttachment.AttachmentType) {
		model.attachmentType = attachmentType
		model.problemDescription = problemDescription
		model.problemImage = problemImage
		
		if attachmentType == .photo {
			goPhotoLocation!()
		} else {
			unwind!()
		}
	}
	
}
