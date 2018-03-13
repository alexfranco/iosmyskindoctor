//
//  SkinProblemLocationViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 28/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemLocationViewModel: BaseViewModel {
	
	static let bodyFrontImage = UIImage(named: "bodyFront")!
	static let bodyBackImage = UIImage(named: "bodyBack")!
	
	var model: SkinProblemAttachment
	
	var locationProblemUpdated: ((_ locationProblemType: SkinProblemAttachment.LocationProblemType)->())?
	var bodyImageChanged: ((_ isFrontSelected: Bool, _ bodyImage: UIImage)->())?
	
	var isFrontSelected: Bool = true {
		didSet {
			self.bodyImageChanged?(isFrontSelected, bodyImage())
		}
	}
	
	var locationProblemType:  SkinProblemAttachment.LocationProblemType = .none {
		didSet {
			self.locationProblemUpdated?(locationProblemType)
		}
	}
	
	func bodyImage() -> UIImage {
		return isFrontSelected ? SkinProblemLocationViewModel.bodyFrontImage: SkinProblemLocationViewModel.bodyBackImage
	}
	
	var problemLocationText: String! {
		get {
			if locationProblemType == .none {
				return "None"
			} else {
				return String.init(format: "%@ %@", isFrontSelected ? "Front": "Back", locationProblemType.description)
			}
		}
	}
	
	required init(model: SkinProblemAttachment) {
		self.model = model
	}
	
	func saveModel() {
		model.locationType = locationProblemType		
		goNextSegue!()
	}
	
}
