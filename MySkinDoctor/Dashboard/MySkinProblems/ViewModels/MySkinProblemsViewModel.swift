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
	
	static let undiagnosedSection = 0
	static let diagnosedSection = 1
	
	var refresh: (()->())?

	var selectedSegmented = DiagnosesSegmentedEnum.all {
		didSet {
			refresh!()
		}
	}
	
	var allItems = [SkinProblemsModel]()
	var undiagnosedItems = [SkinProblemsModel]()
	var diagnosedItems = [SkinProblemsModel]()

	override init() {
		// Generate tests
		
		allItems = [SkinProblemsModel(date: Date(), diagnoseStatus: .diagnosed, skinProblemDescription: "problem 1"),
									  SkinProblemsModel(date: Date(), diagnoseStatus: .noDiagnosed, skinProblemDescription: "problem2")]

		allItems.first?.problems = [SkinProblemModel(location: SkinProblemModel.LocationProblemType.head, problemDescription: "Pain there", problemImage: nil)]
		
		allItems.last?.problems = [SkinProblemModel(location: SkinProblemModel.LocationProblemType.neck, problemDescription: "Pain there", problemImage: nil)]
		
		diagnosedItems = allItems.filter { (model) -> Bool in model.diagnoseStatus == .diagnosed }
		undiagnosedItems = allItems.filter { (model) -> Bool in model.diagnoseStatus != .diagnosed }
	}
	
	func refreshData() {
		// TODO
		refresh!()
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
			headerTitle = section == MySkinProblemsViewModel.undiagnosedSection ? "Undiagnosed (%d)" : "Diagnosed (%d)"
		case .undiagnosed:
			headerTitle = "Undiagnosed (%d)"
		case .diagnosed:
			headerTitle = "Diagnosed (%d)"
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
	
	func getItemAtIndexPath(indexPath: IndexPath) -> SkinProblemsModel {
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
}
