//
//  SkinProblemTableCellViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 27/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class SkinProblemTableCellViewModel : NSObject {
	
	var name: String!
	var location: String!
	var problemDescription: String!
	var problemPlaceHolder: UIImage!
	var problemImageUrl: URL?
		
	required init(withModel model: SkinProblemAttachment, index: Int) {
		self.name = String.init(format: "%@ %d", NSLocalizedString("photo", comment: ""), index + 1)
		
		if model.attachmentTypeEnum == .document {
			self.location = NSLocalizedString("document", comment: "")
		} else {
			self.location = model.locationTypeEnum.description
		}
		
		problemDescription = model.problemDescription
		
		problemPlaceHolder = UIImage.init(color: AppStyle.profileImageViewPlaceHolder)!
		if let problemImage = model.problemImage as? UIImage {
			problemPlaceHolder = problemImage
		}
		
		problemImageUrl = URL.init(string: model.url ?? "")
						
		self.problemDescription = model.problemDescription
		
		super.init()
	}
}

