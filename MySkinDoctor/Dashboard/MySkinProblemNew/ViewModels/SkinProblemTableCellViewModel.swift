//
//  SkinProblemTableCellViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 27/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemTableCellViewModel : NSObject {
	
	var name: String!
	var location: String!
	var problemDescription: String!
	var problemImage: UIImage
		
	required init(withModel model: SkinProblemAttachment, index: Int) {
		self.name = String.init(format: "%@ %d", NSLocalizedString("photo", comment: ""), index + 1)
		
		if model.attachmentTypeEnum == .document {
			self.location = NSLocalizedString("document", comment: "")
		} else {
			self.location = model.locationTypeEnum.description
		}
		
		if let profileImageSafe = model.problemImage as? UIImage {
			problemImage = profileImageSafe
		} else {
			problemImage = UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!
		}
				
		self.problemDescription = model.problemDescription
		
		super.init()
	}
}

