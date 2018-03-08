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
	
	// Variables
	
	private(set) var model: SkinProblemsModel
	var skinProblemDescription = ""
	
	var isEditEnabled: Bool {
		get {
			return diagnoseStatus == .none
		}
	}
	
	var diagnoseStatus: SkinProblemsModel.DiagnoseStatus {
		get {
			return model.diagnoseStatus
		}
	}
	
	var navigationTitle: String {
		get {
			switch diagnoseStatus {
			case .none:
				return NSLocalizedString("addskinproblems_main_vc_title_none", comment: "")
			case .noDiagnosed:
				return NSLocalizedString("addskinproblems_main_vc_title_nodiagnosed", comment: "")
			case .diagnosed:
				return NSLocalizedString("addskinproblems_main_vc_title_diagnosed", comment: "")
			}
		}
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
	
	// MARK Init
	
	override init() {
		model = SkinProblemsModel()
		super.init()
	}
	
	init (model: SkinProblemsModel){
		self.model = model
		super.init()
	}
	
	// Bind properties
	var refresh: (()->())?
	var tableViewStageChanged: ((_ state: EditingStyle)->())?
	var updateNextButton: ((_ isEnabled: Bool)->())?
	var diagnosedStatusChanged: ((_ state: SkinProblemsModel.DiagnoseStatus)->())?
	
	// MARK Helpers
	
	func refreshData() {
		updateNextButton!(nextButtonIsEnabled)
		refresh!()
	}

	func getDataSourceCount() -> Int {
		var count = model.problems.count
		
		if isEditEnabled {
			count += 1
		}
		
		return count
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
	
	func canEditRow(indexPath: IndexPath) -> Bool {
		if isEditEnabled {
			return isAddPhotoRow(indexPath: indexPath)
		} else {
			return false
		}
	}
	
	
	func isAddPhotoRow(indexPath: IndexPath) -> Bool {
		if isEditEnabled {
			return getDataSourceCount() == indexPath.row + 1
		} else {
			return false
		}
	}
	
	func saveModel() {
		model.skinProblemDescription = skinProblemDescription
		model.diagnoseStatus = .noDiagnosed
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
