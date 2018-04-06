//
//  CreditTableViewModel.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation
import UIKit

class CreditTableViewModel : NSObject {
	
	var model: CreditOptionsResponseModel!
	
	var creditsText: String {
		get {
			if let credits = model.credits {
				return credits
			} else {
				return "-"
			}
		}
	}
	
	var buyForText: String {
		get {
			if let amount = model.amount {
				return String(format: "Buy for %@ %@", amount, "GBP")
			} else {
				return "0"
			}
		}
	}
	
	required init(model: CreditOptionsResponseModel) {
		self.model = model
		
		super.init()
	}
}

