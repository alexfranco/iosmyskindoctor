//
//  SkinProblemAttachment.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 13/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import CoreData

extension SkinProblemAttachment {
	
	enum AttachmentType: Int {
		case photo = 1
		case document = 2
	}
	
	enum LocationProblemType: String, CustomStringConvertible {
		
		case none = "none"
		case headAnterior = "HeadAnterior"
		case neckAnterior = "NeckAnterior"
		case chestAnterior = "Chest"
		case abdomenAnterior = "Abdomen"
		case upperArmLeft = "UpperLeftArm"
		case upperArmRight = "UpperRightArm"
		case lowerArmLeft = "LowerLeftArm"
		case lowerArmRight = "LowerRightArm"
		case pubicAndGroinAnterior = "PubicAndGroin"
		case upperLegLeftAnterior = "UpperLeftLegAnterior"
		case upperLegRightAnterior = "UpperRightLegAnterior"
		case lowerLegLeftAnterior = "LowerLeftLegAnterior"
		case lowerLegRightAnterior = "LowerRightLegAnterior"
		case footLeftAnterior = "LeftFoot"
		case footRightAnterior = "RightFoot"
		case headPosterior = "HeadPosterior"
		case neckPosterior = "NeckPosterior"
		case upperBackPosterior = "UpperBack"
		case lowerBackPosterior = "LowerBack"
		case glutealAndPerinealPosterior = "GlutealAndPerineal"
		case upperLegLeftPosterior = "UpperLegLeftPosterior"
		case upperLegRightPosterior = "UpperLegRightPosterior"
		case lowerLegLeftPosterior = "LowerLegLeftPosterior"
		case lowerLegRightPosterior = "LowerLegRightPosterior"
		case ankleLeftPosterior = "AnkleLeft"
		case ankleRightPosterior = "AnkleRight"
		
		static let allValues = [none, headAnterior, neckAnterior, chestAnterior, abdomenAnterior, upperArmLeft, upperArmRight,
								lowerArmLeft, lowerArmRight, pubicAndGroinAnterior, upperLegLeftAnterior, upperLegRightAnterior,
								lowerLegLeftAnterior, lowerLegRightAnterior, footLeftAnterior, footRightAnterior, headPosterior,
								neckPosterior, upperBackPosterior, lowerBackPosterior, glutealAndPerinealPosterior, upperLegLeftPosterior, upperLegRightPosterior, lowerLegLeftPosterior, lowerLegRightPosterior,
								ankleLeftPosterior, ankleRightPosterior]
		
		static func indexOf(locationProblemType: LocationProblemType) -> Int {
			return allValues.index(of: locationProblemType)!
		}
		
		static func element(at index: Int) -> LocationProblemType? {
			if index >= 0 && index < allValues.count {
				return allValues[index]
			} else {
				return nil
			}
		}
		
		var description: String {
			switch self {
			case .none:
				return "None"
			case .headAnterior:
				return "Head Anterior"
			case .neckAnterior:
				return "Neck Anterior"
			case .chestAnterior:
				return "Chest"
			case .abdomenAnterior:
				return "Abdomen"
			case .upperArmLeft:
				return "Upper Left Arm"
			case .upperArmRight:
				return "Upper Right Arm"
			case .lowerArmLeft:
				return "Lower Left Arm"
			case .lowerArmRight:
				return "Lower Left Arm"
			case .pubicAndGroinAnterior:
				return "Pubic And Groin"
			case .upperLegLeftAnterior:
				return "Upper Left Leg"
			case .upperLegRightAnterior:
				return "Upper Right Leg"
			case .lowerLegLeftAnterior:
				return "Lower Left Leg"
			case .lowerLegRightAnterior:
				return "Lower Right Leg"
			case .footLeftAnterior:
				return "Left Foot"
			case .footRightAnterior:
				return "Right Foot"
			case .headPosterior:
				return "Head Posterior"
			case .neckPosterior:
				return "Neck Posterior"
			case .upperBackPosterior:
				return "Upper Back"
			case .lowerBackPosterior:
				return "Lower Back"
			case .glutealAndPerinealPosterior:
				return "Gluteal And Perineal"
			case .upperLegLeftPosterior:
				return "Upper Left Leg Posterior"
			case .upperLegRightPosterior:
				return "Upper Right Leg Posterior"
			case .lowerLegLeftPosterior:
				return "Lower Left Leg Posterior"
			case .lowerLegRightPosterior:
				return "Lower Right Leg Posterior"
			case .ankleLeftPosterior:
				return "Left Ankle"
			case .ankleRightPosterior:
				return "Right Ankle"
			}
		}
	}
	
	var attachmentTypeEnum: AttachmentType {
		get { return AttachmentType(rawValue: Int(self.attachmentType)) ?? .photo }
		set { self.attachmentType = Int16(newValue.rawValue) }
	}

	var locationTypeEnum: LocationProblemType {
		get { return LocationProblemType(rawValue: self.locationType) ?? .none }
		set { self.locationType = newValue.rawValue }
	}
	
	static func convertLocationTypeAnteriorToPosterior(type: LocationProblemType) -> LocationProblemType {
		switch type {
		case .headAnterior:
			return LocationProblemType.headPosterior
		case .neckAnterior:
			return LocationProblemType.neckPosterior
		case .chestAnterior:
			return LocationProblemType.upperBackPosterior
		case .abdomenAnterior:
			return LocationProblemType.lowerBackPosterior
		case .upperArmLeft:
			return LocationProblemType.upperArmRight
		case .upperArmRight:
			return LocationProblemType.upperArmLeft
		case .lowerArmLeft:
			return LocationProblemType.lowerArmRight
		case .lowerArmRight:
			return LocationProblemType.lowerArmLeft
		case .pubicAndGroinAnterior:
			return LocationProblemType.glutealAndPerinealPosterior
		case .upperLegLeftAnterior:
			return LocationProblemType.upperLegRightPosterior
		case .upperLegRightAnterior:
			return LocationProblemType.upperLegLeftPosterior
		case .lowerLegLeftAnterior:
			return LocationProblemType.lowerLegRightPosterior
		case .lowerLegRightAnterior:
			return LocationProblemType.lowerLegRightPosterior
		case .footLeftAnterior:
			return LocationProblemType.ankleRightPosterior
		case .footRightAnterior:
			return LocationProblemType.ankleLeftPosterior
		default:
			return LocationProblemType.none
		}
	}
	
	static func convertLocationTypePosteriorToAnterior(type: LocationProblemType) -> LocationProblemType {
		switch type {
		case .headPosterior:
			return LocationProblemType.headPosterior
		case .neckPosterior:
			return LocationProblemType.neckPosterior
		case .upperBackPosterior:
			return LocationProblemType.chestAnterior
		case .lowerBackPosterior:
			return LocationProblemType.abdomenAnterior
		case .upperArmRight:
			return LocationProblemType.upperArmLeft
		case .upperArmLeft:
			return LocationProblemType.upperArmRight
		case .lowerArmRight:
			return LocationProblemType.lowerArmLeft
		case .lowerArmLeft:
			return LocationProblemType.lowerArmRight
		case .glutealAndPerinealPosterior:
			return LocationProblemType.pubicAndGroinAnterior
		case .upperLegRightPosterior:
			return LocationProblemType.upperLegLeftAnterior
		case .upperLegLeftPosterior:
			return LocationProblemType.upperLegRightAnterior
		case .lowerLegRightPosterior:
			return LocationProblemType.lowerLegLeftAnterior
		case .lowerLegLeftPosterior:
			return LocationProblemType.lowerLegRightAnterior
		case .ankleRightPosterior:
			return LocationProblemType.footLeftAnterior
		case .ankleLeftPosterior:
			return LocationProblemType.footRightAnterior
		default:
			return LocationProblemType.none
		}
	}

}
