//
//  Date.swift
//  Subterminal
//
//  Created by Matthias von Bargen on 21/02/2017.
//  Copyright © 2017 Matthias von Bargen. All rights reserved.
// 
//	Handle all common date operations
//

import Foundation

class DateHelper {
	
	static var dateFormat = "yyyy-MM-dd"
	
	//Format a string to a date object
	static func stringToDate(string: String) -> Date {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = dateFormat
		return dateFormatter.date(from: string)!
	}
	
	//Format a date to a string
	static func dateToString(date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd"

		return formatter.string(from: date)
	}
	
	static func timeAgoSince(date: Date) -> String {
		
		let calendar = Calendar.current
		let now = Date()
		let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
		let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])
		
		if let year = components.year, year >= 2 {
			return "\(year) years ago"
		}
		
		if let year = components.year, year >= 1 {
			return "Last year"
		}
		
		if let month = components.month, month >= 2 {
			return "\(month) months ago"
		}
		
		if let month = components.month, month >= 1 {
			return "Last month"
		}
		
		if let week = components.weekOfYear, week >= 2 {
			return "\(week) weeks ago"
		}
		
		if let week = components.weekOfYear, week >= 1 {
			return "Last week"
		}
		
		if let day = components.day, day >= 2 {
			return "\(day) days ago"
		}
		
		if let day = components.day, day >= 1 {
			return "Yesterday"
		}
		
		if let hour = components.hour, hour >= 2 {
			return "\(hour) hours ago"
		}
		
		if let hour = components.hour, hour >= 1 {
			return "An hour ago"
		}
		
		if let minute = components.minute, minute >= 2 {
			return "\(minute) minutes ago"
		}
		
		if let minute = components.minute, minute >= 1 {
			return "A minute ago"
		}
		
		if let second = components.second, second >= 3 {
			return "\(second) seconds ago"
		}
		
		return "Just now"
		
	}
}
