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
		
		if let profileImageSafe = model.problemImage as? UIImage {
			problemImage = profileImageSafe
		} else {
			problemImage = UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!
		}
	}
	
	func saveModel(attachmentType: SkinProblemAttachment.AttachmentType) {
		model.attachmentTypeEnum = attachmentType
		model.problemDescription = problemDescription
		model.problemImage = problemImage
		
		if attachmentType == .photo {
			goPhotoLocation!()
		} else {
			unwind!()
		}
	}
	
}
