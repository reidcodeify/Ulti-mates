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
import GooglePlaces

// MARK: Struct
class Event: Object {
	// MARK: Properties
	dynamic var eventName: String = ""
	dynamic var date: NSDate = NSDate()
	dynamic var location: RealmPlace? = nil
	var players = List<ActiveAccount>()
	
	// MARK: Life Cycle
	convenience init (eventName: String, date: NSDate, location: GMSPlace) {
		self.init()
		self.eventName = eventName
		self.date = date
		self.location = RealmPlace(withPlace: location)
	}
	
	// MARK: Private
	
	// MARK: Public
	func updateDate(date: NSDate) {
		self.date = date
	}
	
	func updateLocation(location: GMSPlace) {
		self.location?.name = location.name
		self.location?.longtitude = location.coordinate.longitude
		self.location?.latitude = location.coordinate.latitude
	}

}
