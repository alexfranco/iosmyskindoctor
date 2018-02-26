//
//  DateUtils.swift
//  MySkinDoctor
//
//  Created by Alex on 26/02/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

class DateUtils {
	
	static func getOrdinaryDay(date: Date) -> String {
		// Day
		let calendar = Calendar.current
		let anchorComponents = calendar.dateComponents([.day, .month, .year], from: date)
		
		var day  = "\(anchorComponents.day!)"
		switch (day) {
		case "1" , "21" , "31":
			day.append("st")
		case "2" , "22":
			day.append("nd")
		case "3" ,"23":
			day.append("rd")
		default:
			day.append("th")
		}
		
		return day
	}
}

