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
	
	var skinProblemDescription = ""
	
	var refresh: (()->())?

	var items = [SkinProblemModel]()
	
	override init() {
		// Generate tests
		items = [SkinProblemModel(withName: "Face", location: "Feet", problemDescription: "A lot of pain", problemImage: nil, date: Date())]
	}
	
	func refreshData() {
		refresh!()
	}
	
	func getDataSourceCount(section: Int) -> Int {
		return items.count + 1
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> SkinProblemModel {
		return items[indexPath.row]
	}
	
	func getNumberOfSections() -> Int {
		return 1
	}
}
