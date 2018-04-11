//
//  MySkinProblemsViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class MySkinProblemsViewModel: BaseViewModel {
	
	enum DiagnosesSegmentedEnum: Int {
		case all
		case undiagnosed
		case diagnosed
	}
	
	var selectedSegmented = DiagnosesSegmentedEnum.all {
		didSet {
			refresh!()
		}
	}
	
	var refresh: (()->())?
	var allItems = [SkinProblems]()
	var undiagnosedItems = [SkinProblems]()
	var diagnosedItems = [SkinProblems]()
	
	override init() {
		super.init()
		self.loadDBModel()
	}
	
	func refreshData() {
		self.fetchInternetModel()
	}
	
	override func fetchInternetModel() {
		super.fetchInternetModel()
		
		ApiUtils.getAllSkinProblems(accessToken: DataController.getAccessToken()) { (result) in

			print("getAllSkinProblems Finished")
			
			switch result {
			case .success(let model):
				
				for skinProblemsResponseModel in model as! [SkinProblemsResponseModel] {
					let _ = SkinProblems.parseAndSaveResponse(skinProblemResponseModel: skinProblemsResponseModel)
				}
				
				self.loadDBModel()
				
				if self.onFetchFinished != nil {
					self.onFetchFinished!()
				}
				
			case .failure(_, let error):
				print("error \(error.localizedDescription)")
				self.showResponseErrorAlert!(nil, error)
			}
		}
	}

	override func loadDBModel() {
		super.loadDBModel()
		
		if let results = DataController.fetchAll(type: SkinProblems.self, sortByKey: "skinProblemId") {
			allItems = results
			diagnosedItems = allItems.filter { (model) -> Bool in model.isDiagnosed }
			undiagnosedItems = allItems.filter { (model) -> Bool in !model.isDiagnosed }
		}
		
		if refresh != nil { refresh!() }
	}
	
	func removeModel(at indexPath: IndexPath) {
		isLoading = true
		
		let item = getItemAtIndexPath(indexPath: indexPath)
		
		ApiUtils.deleteSkinProblem(accessToken: DataController.getAccessToken(), skinProblemsId: Int(item.skinProblemId)) { (result) in
			self.isLoading = false
			
			switch result {
			case .success(_):
				print("getSkinProblems")
				DataController.deleteManagedObject(managedObject: item)
				self.refreshData()
			case .failure(_, let error):
				print("error \(error.localizedDescription)")
				self.showResponseErrorAlert!(nil, error)
			}
		}
	}
}
	
extension MySkinProblemsViewModel {
	
	static let undiagnosedSection = 0
	static let diagnosedSection = 1
	
	var shouldShowSetupWizard: Bool {
		get {
			return UserDefaults.standard.bool(forKey: UserDefaultConsts.isFirstTime)
		}
	}
	
	func wizardShown() {
		let defaults = UserDefaults.standard
		defaults.set(false, forKey: UserDefaultConsts.isFirstTime)
	}
	
	func getHeaderBackgroundColor(section: Int) -> UIColor {
		switch selectedSegmented {
		case .all:
			return section == MySkinProblemsViewModel.undiagnosedSection ? AppStyle.mySkinUndiagnosedColor : AppStyle.mySkinDiagnosedColor
		case .undiagnosed:
			return AppStyle.mySkinUndiagnosedColor
		case .diagnosed:
			return AppStyle.mySkinDiagnosedColor
		}
	}
	
	func getSectionTitle(section: Int) -> String {
		var headerTitle: String!
		
		switch selectedSegmented {
		case .all:
			headerTitle = section == MySkinProblemsViewModel.undiagnosedSection ? String.init(format: "%@ (%d)", NSLocalizedString("myskinproblems_segmented_undiagnosed", comment: ""), undiagnosedItems.count) : String.init(format: "%@ (%d)", NSLocalizedString("myskinproblems_segmented_diagnosed", comment: ""), diagnosedItems.count)
		case .undiagnosed:
			headerTitle = String.init(format: "%@ (%d)", NSLocalizedString("myskinproblems_segmented_undiagnosed", comment: ""), undiagnosedItems.count)
		case .diagnosed:
			headerTitle = String.init(format: "%@ (%d)", NSLocalizedString("myskinproblems_segmented_diagnosed", comment: ""), diagnosedItems.count)
		}
		
		return String.init(format: headerTitle.uppercased(), getDataSourceCount(section: section))
	}
	
	func getDataSourceCount(section: Int) -> Int {
		switch selectedSegmented {
		case .all:
			return section == MySkinProblemsViewModel.undiagnosedSection ? undiagnosedItems.count : diagnosedItems.count
		case .undiagnosed:
			return undiagnosedItems.count
		case .diagnosed:
			return diagnosedItems.count
		}
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> SkinProblems {
		switch selectedSegmented {
		case .all:
			return indexPath.section == MySkinProblemsViewModel.undiagnosedSection ? undiagnosedItems[indexPath.row] : diagnosedItems[indexPath.row]
		case .undiagnosed:
			return undiagnosedItems[indexPath.row]
		case .diagnosed:
			return diagnosedItems[indexPath.row]
		}
	}
	
	func getNumberOfSections() -> Int {
		switch selectedSegmented {
		case .all:
			let dataSourceCount = getDataSourceCount(section: MySkinProblemsViewModel.undiagnosedSection) > 0 || getDataSourceCount(section: MySkinProblemsViewModel.diagnosedSection) > 0
			return dataSourceCount ? 2 : 0
		case .undiagnosed:
			return getDataSourceCount(section: MySkinProblemsViewModel.undiagnosedSection) > 0 ? 1 : 0
		case .diagnosed:
			return getDataSourceCount(section: MySkinProblemsViewModel.undiagnosedSection) > 0 ? 1 : 0
		}
	}
	
	func canEditRow(indexPath: IndexPath) -> Bool {
		if let diagnose = getItemAtIndexPath(indexPath: indexPath).diagnose {
			return diagnose.diagnoseStatusEnum == .draft
		}
		return false
	}
}
