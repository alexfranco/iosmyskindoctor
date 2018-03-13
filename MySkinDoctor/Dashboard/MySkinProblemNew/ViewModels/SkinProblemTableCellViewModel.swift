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
		self.name = String.init(format: "Photo %d", index + 1)
		self.location = model.locationType.description
		self.problemImage = model.problemImage == nil ? UIImage(named: "logo")! : model.problemImage as! UIImage
		self.problemDescription = model.problemDescription
		
		super.init()
	}
}

