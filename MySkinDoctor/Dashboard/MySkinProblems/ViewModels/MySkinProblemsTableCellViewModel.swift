//
//  MySkinProblemsTableCellViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 23/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class MySkinProblemsTableCellViewModel: NSObject {
	var name: String?
	
	required init(withName name: String) {
		super.init()
		
		self.name = name
	}
}
