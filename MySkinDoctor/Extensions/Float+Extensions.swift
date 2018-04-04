//
//  Float+Extensions.swift
//  MySkinDoctor
//
//  Created by Alex on 04/04/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

extension Float {
	func string(fractionDigits:Int) -> String {
		let formatter = NumberFormatter()
		formatter.minimumFractionDigits = fractionDigits
		formatter.maximumFractionDigits = fractionDigits
		return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
	}
}
