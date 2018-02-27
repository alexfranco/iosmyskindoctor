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
		
	required init(withName name: String, location: String, problemDescription: String, problemImage: UIImage) {
		
		self.name = name
		self.location = location
		self.problemImage = problemImage
		self.problemDescription = problemDescription
		
		super.init()
	}
}

