//
//  SkinProblemModel.swift
//  MySkinDoctor
//
//  Created by Alex on 28/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class SkinProblemModel : NSObject {
	
	var name: String!
	var location: String!
	var problemImage: UIImage
	var problemDescription: String!
	
	required init(withName name: String, location: String, problemDescription: String, problemImage: UIImage) {
		
		self.name = name
		self.location = location
		self.problemImage = problemImage
		self.problemDescription = problemDescription
		
		super.init()
	}
}
