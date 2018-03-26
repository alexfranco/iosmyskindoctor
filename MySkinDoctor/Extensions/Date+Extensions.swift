//
//  Date+Extensions.swift
//  MySkinDoctor
//
//  Created by Alex on 05/03/2018.
//  Copyright © 2018 TouchSoft. All rights reserved.
//

import Foundation

// The date components available to be retrieved or modifed
public enum DateComponentType {
	case second, minute, hour, day, weekday, nthWeekday, week, month, year
}

extension Date {

	func ordinal() -> String {
		// Day
		let calendar = Calendar.current
		let anchorComponents = calendar.dateComponents([.day, .month, .year], from: self)
		
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
	
	func ordinalMonthAndYear() -> String {
		// Formater
		let dateFormater = DateFormatter()
		dateFormater.dateFormat = "MMMM, yyyy"
		return self.ordinal() + " " + dateFormater.string(from: self)
	}
	
	func adjust(_ component:DateComponentType, offset:Int) -> Date {
		var dateComp = DateComponents()
		switch component {
		case .second:
			dateComp.second = offset
		case .minute:
			dateComp.minute = offset
		case .hour:
			dateComp.hour = offset
		case .day:
			dateComp.day = offset
		case .weekday:
			dateComp.weekday = offset
		case .nthWeekday:
			dateComp.weekdayOrdinal = offset
		case .week:
			dateComp.weekOfYear = offset
		case .month:
			dateComp.month = offset
		case .year:
			dateComp.year = offset
		}
		return Calendar.current.date(byAdding: dateComp, to: self)!
	}

	/// Return a new Date object with the new hour, minute and seconds values.
	func adjust(hour: Int?, minute: Int?, second: Int?, day: Int? = nil, month: Int? = nil) -> Date {
		var comp = Date.components(self)
		comp.month = month ?? comp.month
		comp.day = day ?? comp.day
		comp.hour = hour ?? comp.hour
		comp.minute = minute ?? comp.minute
		comp.second = second ?? comp.second
		return Calendar.current.date(from: comp)!
	}
	
	// MARK: Extracting components
	
	func component(_ component:DateComponentType) -> Int? {
		let components = Date.components(self)
		switch component {
		case .second:
			return components.second
		case .minute:
			return components.minute
		case .hour:
			return components.hour
		case .day:
			return components.day
		case .weekday:
			return components.weekday
		case .nthWeekday:
			return components.weekdayOrdinal
		case .week:
			return components.weekOfYear
		case .month:
			return components.month
		case .year:
			return components.year
		}
	}
	
	// MARK: Internal Components
	
	internal static func componentFlags() -> Set<Calendar.Component> { return [Calendar.Component.year, Calendar.Component.month, Calendar.Component.day, Calendar.Component.weekOfYear, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second, Calendar.Component.weekday, Calendar.Component.weekdayOrdinal, Calendar.Component.weekOfYear] }
	internal static func components(_ fromDate: Date) -> DateComponents {
		return Calendar.current.dateComponents(Date.componentFlags(), from: fromDate)
	}
	
	var iso8601: String {
		return Formatter.iso8601.string(from: self)
	}
}
