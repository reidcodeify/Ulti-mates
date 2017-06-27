//
//  Event.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift

// MARK: Struct
class Event: Object {
	// MARK: Properties
	dynamic var eventName: String = ""
	var players = List<ViewableAccount>()
	dynamic var date: NSDate = NSDate()
	dynamic var location: String = ""
	
	// MARK: Life Cycle
	convenience init (eventName: String, date: NSDate, location: String) {
		self.init()
		self.eventName = eventName
		self.date = date
		self.location = location
	}
	
	// MARK: Private
	
	// MARK: Public
	func updateDate(date: NSDate) {
		self.date = date
	}
	
	func updateLocation(location: String) {
		self.location = location
	}
}
