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
	
	enum EditingStyle {
		case insert(SkinProblemModel, IndexPath)
		case delete(IndexPath)
		case none
	}
	
	private(set) var model: SkinProblemsModel
	var skinProblemDescription = ""
	
	// Bind properties
	var refresh: (()->())?
	var tableViewStageChanged: ((_ state: EditingStyle)->())?
	var updateNextButton: ((_ isEnabled: Bool)->())?
	
	override init() {
		model = SkinProblemsModel()
		super.init()
	}
	
	func refreshData() {
		updateNextButton!(nextButtonIsEnabled)
		refresh!()
	}

	var nextButtonIsEnabled: Bool {
		get {
			return self.model.problems.count > 0
		}
	}
	
	private(set) var tableViewState: EditingStyle = EditingStyle.none {
		didSet {
			
			switch tableViewState {
			case let .insert(new, indexPath):
				model.problems.insert(new, at: indexPath.row)
			case let .delete(indexPath):
				model.problems.remove(at: indexPath.row)
			default:
				break
			}
			
			tableViewStageChanged!(tableViewState)
		}
	}
	
	func getDataSourceCount() -> Int {
		return model.problems.count + 1
	}
	
	func getDataSourceCountWithoutExtraAddPhoto() -> Int {
		return model.problems.count
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
	
	func insertNewModel(model: SkinProblemModel, indexPath: IndexPath) {
		tableViewState = .insert(model, indexPath)
		updateNextButton!(nextButtonIsEnabled)
	}
	
	func appendNewModel(model: SkinProblemModel) {
		let appendToLastIndexPath = IndexPath.init(row: getDataSourceCountWithoutExtraAddPhoto(), section: 0)
		tableViewState = .insert(model, appendToLastIndexPath)
		updateNextButton!(nextButtonIsEnabled)
	}
	
	func removeModel(at indexPath: IndexPath) {
		tableViewState = .delete(indexPath)
		updateNextButton!(nextButtonIsEnabled)
	}
}
