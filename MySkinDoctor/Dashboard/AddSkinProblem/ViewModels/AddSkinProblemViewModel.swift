//
//  AddSkinProblemViewModel.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 27/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class AddSkinProblemViewModel: BaseViewModel {
	
	var refresh: (()->())?

	var items = [SkinProblemTableCellViewModel]()
	
	override init() {
		// Generate tests
		items = [SkinProblemTableCellViewModel(withName: "Name", location: "My location", problemDescription: "My problem", problemImage: UIImage(named: "logo")!)]
	}
	
	func refreshData() {
		refresh!()
	}
	
	
	func getDataSourceCount(section: Int) -> Int {
		return items.count + 1
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> SkinProblemTableCellViewModel {
		return items[indexPath.row]
	}
	
	func getNumberOfSections() -> Int {
		return 1
	}
}
