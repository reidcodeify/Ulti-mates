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
	dynamic var eventDescription: String = ""
	var activePlayers = List<ActiveAccount>()
	var maybePlayers = List<ActiveAccount>()
	
	// MARK: Life Cycle
	
	/// Initializer that takes an eventName, date, and a location
	///
	/// - Parameter eventName: An instance of String that holds the event's displayed name
	/// - Parameter date: An instance of NSDate that holds the event's start time and date
	/// - Parameter location: An instance of GMSPlace that holds the event's location information provided by the Google Places APi
	convenience init (eventName: String, date: NSDate, location: GMSPlace, eventDescription: String) {
		self.init()
		self.eventName = eventName
		self.date = date
		self.location = RealmPlace(withPlace: location)
		self.eventDescription = eventDescription
	}
	
	// MARK: Private
	
	// MARK: Public
	
	/// Takes a date and updates the respective local value with it
	///
	/// - Parameter date: An instance of NSDate
	func updateDate(date: NSDate) {
		self.date = date
	}
	
	/// Takes a location and updates the respective local value with it
	///
	/// - Parameter location: An instance of GMSPlace
	func updateLocation(location: GMSPlace) {
		self.location?.name = location.name
		self.location?.longtitude = location.coordinate.longitude
		self.location?.latitude = location.coordinate.latitude
	}

}
