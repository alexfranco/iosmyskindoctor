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
	var problemDescription = ""
	var problemImage: UIImage!
	
	var goPhotoLocation: (()->())?
	var unwind: (()->())?
	
	required init(model: SkinProblemAttachment) {
		self.model = model
		self.problemDescription = model.problemDescription ?? ""
		
		if let profileImageSafe = model.problemImage as? UIImage {
			problemImage = profileImageSafe
		} else {
			problemImage = UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!
		}
	}
	
	override func validateForm() -> Bool {
		var isValid = true
		
		if problemDescription.isEmpty {
			showAlert!("", NSLocalizedString("skinproblems_photo_information_description_text_view_empty", comment: ""))
			isValid = false
		}
				
		return isValid
	}
	
	func saveModel(attachmentType: SkinProblemAttachment.AttachmentType) {
		
		if !self.validateForm() {
			return
		}
		
		model.attachmentTypeEnum = attachmentType
		model.problemDescription = problemDescription
		model.problemImage = problemImage
		model.filename = AWS3Utils.storeImage(image: problemImage)
		
		if attachmentType == .photo {
			goPhotoLocation!()
		} else {
			unwind!()
		}
	}
	
}
