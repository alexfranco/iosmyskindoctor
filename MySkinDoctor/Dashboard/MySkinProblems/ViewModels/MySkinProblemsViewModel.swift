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
		
		allItems = [SkinProblemsModel(date: Date(), diagnoseStatus: .noFutherCommunicationRequired, skinProblemDescription: "problem 1"),
					SkinProblemsModel(date: Date(), diagnoseStatus: .pending, skinProblemDescription: "problem2"),
					SkinProblemsModel(date: Date(), diagnoseStatus: .bookConsultationRequest, skinProblemDescription: "problem 3")]

		allItems.first?.diagnose.diagnosedBy = Doctor(firstName: "Dr Jones", lastName: "Pepito")
		allItems.first?.diagnose.diagnoseDate = Date().adjust(.day, offset: -5)
		allItems.first?.diagnose.diagnosedBy?.qualifications = "A lot of them"
		allItems.first?.diagnose.summary = "My summary"
		allItems.first?.diagnose.treatment = "My treatment"
		allItems.first?.diagnose.patientInformation = "My patinet info"
		allItems.first?.diagnose.comments = "My comments"
		allItems.first?.problems = [SkinProblemModel(location: SkinProblemModel.LocationProblemType.head, problemDescription: "Pain there", problemImage: nil)]
		
		allItems.last?.problems = [SkinProblemModel(location: SkinProblemModel.LocationProblemType.neck, problemDescription: "Pain there", problemImage: nil)]
		
		allItems.last?.diagnose.diagnosedBy = Doctor(firstName: "Dr Amor", lastName: "love")
		allItems.last?.diagnose.diagnosedBy?.qualifications = "A lot of them"
		allItems.last?.diagnose.diagnoseDate = Date().adjust(.day, offset: -10)
		allItems.last?.diagnose.doctorNotes = [DoctorNote(date: Date(), note: "my first note"),
											   DoctorNote(date: Date().adjust(.day, offset: -10), note: "my first 2")]
		allItems.last?.problems = [SkinProblemModel(location: SkinProblemModel.LocationProblemType.neck, problemDescription: "Pain there", problemImage: nil)]
		
		diagnosedItems = allItems.filter { (model) -> Bool in model.isDiagnosed }
		undiagnosedItems = allItems.filter { (model) -> Bool in !model.isDiagnosed }
	}
	
	func refreshData() {
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
