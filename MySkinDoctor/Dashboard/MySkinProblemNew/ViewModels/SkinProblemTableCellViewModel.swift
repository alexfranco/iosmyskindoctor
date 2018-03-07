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
		
	required init(withModel model: SkinProblemModel) {
		self.name = "TODO"
		self.location = model.location.description
		self.problemImage = model.problemImage == nil ? UIImage(named: "logo")! : model.problemImage! // TODO change it to a default image
		self.problemDescription = model.problemDescription
		
		super.init()
	}
}

