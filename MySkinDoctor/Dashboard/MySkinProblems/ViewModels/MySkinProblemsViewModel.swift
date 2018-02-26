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
	
	static let undiagnosedSection = 0
	static let diagnosedSection = 1
	
	var items = [MySkinProblemsTableCellViewModel]()
	
	var undiagnosedItems = [MySkinProblemsTableCellViewModel]()
	var diagnosedItems = [MySkinProblemsTableCellViewModel]()


	override init() {
		// Generate tests
		items = [MySkinProblemsTableCellViewModel(withName: "New Skin Problem", date: Date(), isDiagnosed: true, problemDescription: "My son has suffered with several rashes spanning over the space of 5 months which come and go...."),
				 MySkinProblemsTableCellViewModel(withName: "Serious", date: Date(), isDiagnosed: false, problemDescription: "I do have some skin issues")]
		
		diagnosedItems = items.filter { (model) -> Bool in model.isDiagnosed == true }
		undiagnosedItems = items.filter { (model) -> Bool in model.isDiagnosed == false }
	}
	
	func getSectionTitle(section: Int) -> String {
		let headerTitle =  section == MySkinProblemsViewModel.undiagnosedSection ? "Undiagnosed (%d)" : "Diagnosed (%d)"
		return String.init(format: headerTitle.uppercased(), getDataSourceCount(section: section))
	}
	
	func getDataSourceCount(section: Int) -> Int {
		return section == MySkinProblemsViewModel.undiagnosedSection ? undiagnosedItems.count : diagnosedItems.count
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> MySkinProblemsTableCellViewModel {
		return indexPath.section == MySkinProblemsViewModel.undiagnosedSection ? undiagnosedItems[indexPath.row] : diagnosedItems[indexPath.row]
	}
}
