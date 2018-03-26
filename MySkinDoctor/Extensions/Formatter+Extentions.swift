//
//  Formatter+Extentions.swift
//  MySkinDoctor
//
//  Created by Alex Núñez on 22/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

extension Formatter {
	static let iso8601: DateFormatter = {
		let formatter = DateFormatter()
		formatter.calendar = Calendar(identifier: .iso8601)
		formatter.timeZone = TimeZone(secondsFromGMT: 0)
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
		return formatter
	}()
}
