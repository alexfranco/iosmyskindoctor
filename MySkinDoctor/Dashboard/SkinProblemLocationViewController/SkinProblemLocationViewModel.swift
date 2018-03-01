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
	
	var model: SkinProblemModel
	
	var locationProblemUpdated: ((_ locationProblemType: SkinProblemModel.LocationProblemType)->())?
	var bodyImageChanged: ((_ isFrontSelected: Bool, _ bodyImage: UIImage)->())?
	
	var isFrontSelected: Bool = true {
		didSet {
			self.bodyImageChanged?(isFrontSelected, bodyImage())
		}
	}
	
	var locationProblemType:  SkinProblemModel.LocationProblemType = .none {
		didSet {
			self.locationProblemUpdated?(locationProblemType)
		}
	}
	
	func bodyImage() -> UIImage {
		return isFrontSelected ? SkinProblemLocationViewModel.bodyFrontImage: SkinProblemLocationViewModel.bodyBackImage
	}
	
	var problemLocationText: String! {
		get {
			return String.init(format: "%@ %@", isFrontSelected ? "Front": "Back", locationProblemType.description)
		}
	}
	
	required init(model: SkinProblemModel) {
		self.model = model
	}
	
	func saveModel() {
		model.location = locationProblemType
		goNextSegue!()
	}
	
}
