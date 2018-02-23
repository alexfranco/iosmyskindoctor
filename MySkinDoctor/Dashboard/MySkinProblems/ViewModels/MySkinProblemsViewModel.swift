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
	
	var items = [MySkinProblemsTableCellViewModel]()

	override init() {
		// Generate tests
		items = [MySkinProblemsTableCellViewModel(withName: "Hola"), MySkinProblemsTableCellViewModel(withName: "Adios")]
	}
	
	func getDataSourceCount() -> Int {
		return items.count
	}
	
	func getItemAtIndexPath(indexPath: IndexPath) -> MySkinProblemsTableCellViewModel {
		return items[indexPath.row]
	}

}



