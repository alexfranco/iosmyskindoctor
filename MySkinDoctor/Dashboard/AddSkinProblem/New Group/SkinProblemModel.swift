//
//  SkinProblemModel.swift
//  MySkinDoctor
//
//  Created by Alex on 28/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemModel : NSObject {
	
	var name: String?
	var location: String?
	var problemImage: UIImage?
	var problemDescription: String?
	var date: Date?
	var isDiagnosed: Bool
	
	required init(withName name: String? = "", location: String? = "", problemDescription: String? = "", problemImage: UIImage?, date: Date? = Date(), isDiagnosed: Bool = false) {
		
		self.name = name
		self.location = location
		self.problemImage = problemImage
		self.problemDescription = problemDescription
		self.date = date
		self.isDiagnosed = isDiagnosed
		
		super.init()
	}
}

