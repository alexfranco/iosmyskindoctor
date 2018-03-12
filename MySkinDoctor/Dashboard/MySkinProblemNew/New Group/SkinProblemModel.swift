//
//  SkinProblemModel.swift
//  MySkinDoctor
//
//  Created by Alex on 28/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemModel: NSObject {
	
	enum AttachmentType: Int {
		case photo
		case document
	}
	enum LocationProblemType: Int, CustomStringConvertible {
		case none
		case head
		case neck
		case chest
		case belly
		case upperArmLeft
		case upperArmRight
		case lowerArmLeft
		case lowerArmRight
		case pelvis
		case upperLegLeft
		case upperLegRight
		case lowerLegLeft
		case lowerLegRight
		case footLeft
		case footRight
		
		
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
			case .chest:
				return "Chest"
			case .belly:
				return "Belly"
			case .upperArmLeft:
				return "Upper Arm Left"
			case .upperArmRight:
				return "Upper Arm Right"
			case .lowerArmLeft:
				return "Lower Arm Left"
			case .lowerArmRight:
				return "Lower Arm Right"
			case .pelvis:
				return "Pelvis"
			case .upperLegLeft:
				return "Upper Leg Left"
			case .upperLegRight:
				return "Upper Leg Right"
			case .lowerLegLeft:
				return "Lower Leg Left"
			case .lowerLegRight:
				return "Lower Leg Right"
			case .footLeft:
				return "Foot Left"
			case .footRight:
				return "Foot Right"
				
			}
		}
	}
	
	var location: LocationProblemType = LocationProblemType.none
	var problemImage: UIImage?
	var problemDescription: String?
	var attachmentType = AttachmentType.photo
	
	required init(location: LocationProblemType = LocationProblemType.none, problemDescription: String? = "", problemImage: UIImage?) {
		
		self.location = location
		self.problemImage = problemImage
		self.problemDescription = problemDescription
				
		super.init()
	}
}

