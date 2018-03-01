//
//  AddSkinProblemsViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 27/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class AddSkinProblemsViewModel: BaseViewModel {
	
	var skinProblemDescription = ""
	
	var refresh: (()->())?
	
	var updateNextButton: ((_ isEnabled: Bool)->())?

	var model: SkinProblemsModel!
	
	override init() {
		super.init()
		model = SkinProblemsModel()
	}
	
	func refreshData() {
		updateNextButton!(self.nextButtonIsEnabled)
		refresh!()
	}

	var nextButtonIsEnabled: Bool {
		get {
			return self.model.problems.count > 0
		}
	}
	
	func getDataSourceCount(section: Int) -> Int {
		return model.problems.count + 1
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> SkinProblemModel {
		return model.problems[indexPath.row]
	}
	
	func getNumberOfSections() -> Int {
		return 1
	}
	
	func saveModel() {
		model.skinProblemDescription = skinProblemDescription
		goNextSegue!()
	}
	
	func addNewModel(model: SkinProblemModel) {
		self.model.problems.append(model)
		refreshData()
	}
}
