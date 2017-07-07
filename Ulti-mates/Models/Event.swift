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
	var players = List<ActiveAccount>()
	dynamic var date: NSDate = NSDate()
	dynamic var locationName: String = ""
	dynamic var locationLongitude: Double = 0
	dynamic var locationLatitude: Double = 0
	
	// MARK: Life Cycle
	convenience init (eventName: String, date: NSDate, locationName: String, locationLongitude: Double, locationLatitude: Double) {
		self.init()
		self.eventName = eventName
		self.date = date
		self.locationName = locationName
		self.locationLongitude = locationLongitude
		self.locationLatitude = locationLatitude
	}
	
	// MARK: Private
	
	// MARK: Public
	func updateDate(date: NSDate) {
		self.date = date
	}
	
	func updateLocationName(location: String) {
		self.locationName = location
	}
	
	func updateLocationLongitude(longitude: Double) {
		self.locationLongitude = longitude
	}
	
	func updateLocationLatitude(latitude: Double) {
		self.locationLatitude = latitude
	}
}
