//
//  SkinProblemLocationViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 28/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class SkinProblemLocationViewModel: BaseViewModel {
	private var model: SkinProblemModel
	var problemLocation: String!
	
	required init(model: SkinProblemModel) {
		self.model = model
	}
	
}
