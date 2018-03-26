//
//  String+Extentions.swift
//  MySkinDoctor
//
//  Created by Alex on 26/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

extension String {
	var dateFromISO8601: Date? {
		return Formatter.iso8601.date(from: self)   // "Mar 22, 2017, 10:22 AM"
	}
}
