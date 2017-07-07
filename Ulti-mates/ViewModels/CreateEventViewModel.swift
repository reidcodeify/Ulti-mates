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
	init (realm: Realm) {
		self.realm = realm
	}
	
	// MARK: Private
	
	// MARK: Public
	func checkRequirements() {
		if (!eventName.isEmpty && date != nil && location != nil) {
			canFinish.value = true
		} else {
			canFinish.value = false
		}
	}
	
	func updateEventName(eventName: String) {
		self.eventName = eventName
	}
	
	func updateDate(date: NSDate) {
		self.date = date
	}
}
