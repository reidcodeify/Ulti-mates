//
//  CreateEventViewModel.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/16/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift
import GooglePlaces

// MARK: Class
class CreateEventViewModel {
	// MARK: Properties
	var realm: Realm
	var eventName: String = ""
	var date: NSDate?
	var location: GMSPlace?
	var canFinish = UpdatableProperty(value: false)
	
	// MARK: Life Cycle
	
	/// Initializer that takes a realm
	///
	/// - Parameter realm: An instance of Realm
	init (realm: Realm) {
		self.realm = realm
	}
	
	// MARK: Private
	
	// MARK: Public
	
	/// Creating event requires that all displayed textFields are completed. Asserts this validation 
	func checkRequirements() {
		if (!eventName.isEmpty && date != nil && location != nil) {
			canFinish.update(true)
		} else {
			canFinish.update(false)
		}
	}
	
	/// Takes an eventName and updates the respective local value with it
	///
	/// - Parameter eventName: An instance of String that represents the event's name
	func updateEventName(eventName: String) {
		self.eventName = eventName
	}
	
	/// Takes a date and updates the respective local value with it
	///
	/// - Parameter date: An instance of NSDate that represents the event's start time and date
	func updateDate(date: NSDate) {
		self.date = date
	}
}
