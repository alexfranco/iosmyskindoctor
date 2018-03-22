//
//  Formatter+Extentions.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 22/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

extension Formatter {
	static let iso8601: ISO8601DateFormatter = {
		let formatter = ISO8601DateFormatter()
		formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
		return formatter
	}()
}
