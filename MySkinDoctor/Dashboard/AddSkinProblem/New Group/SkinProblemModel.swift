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
	
	enum LocationProblemType: Int, CustomStringConvertible {
		case none
		case head
		case neck
		
		var index: Int {
			return rawValue
		}
		var description: String {
			switch self {
			case .none:
				return "None"
			case .head:
				return "Head"
			case .neck:
				return "Neck"
			}
		}
	}
	
	var name: String?
	var location: LocationProblemType = LocationProblemType.none
	var problemImage: UIImage?
	var problemDescription: String?
	var date: Date?
	var isDiagnosed: Bool
	
	required init(withName name: String? = "", location: LocationProblemType = LocationProblemType.none, problemDescription: String? = "", problemImage: UIImage?, date: Date? = Date(), isDiagnosed: Bool = false) {
		
		self.name = name
		self.location = location
		self.problemImage = problemImage
		self.problemDescription = problemDescription
		self.date = date
		self.isDiagnosed = isDiagnosed
		
		super.init()
	}
}

