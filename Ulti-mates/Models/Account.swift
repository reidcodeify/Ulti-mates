//
//  Account.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

// MARK: Protocol
protocol Profilable {
	var name: String { get }
	var biography: String? { get }
	var yearsPlayed: Int { get }
	var favoritedEvents: List<Event> { get }
	var friends: List<ViewableAccount> { get }
	var location: String { get }
}

// MARK: Class
class ActiveAccount: Object, Profilable {
	// MARK: Properties
	dynamic var name: String = ""
	dynamic var email: String = ""
	dynamic var password: String = ""
	dynamic var zipcode: String = ""
	dynamic var yearsPlayed: Int = 0 // *calculate time played from a given date?
	dynamic var biography: String? = nil
	dynamic var location: String = ""
	var favoritedEvents = List<Event>()
	var friends = List<ViewableAccount>()
	
	// MARK: Life Cycle
	convenience init (name: String, email: String, password: String, zipcode: String, yearsPlayed: Int) {
		self.init()
		self.name = name
		self.email = email
		self.password = password
		self.zipcode = zipcode
		self.yearsPlayed = yearsPlayed
	}
	
	// MARK: Public
	func updateName(name: String) {
		self.name = name
	}
	
	func updateEmail(email: String) {
		self.email = email
	}
	
	func updatePassword(password: String) {
		self.password = password
	}
	
	func updateZipcode(zipcode: String) {
		self.zipcode = zipcode
	}
	
	func updateBiography(biography: String) {
		self.biography = biography
	}
	
	func updateYearsPlayed(yearsPlayed: Int) {
		self.yearsPlayed = yearsPlayed
	}
}

// MARK: Class
class ViewableAccount: Object, Profilable {
	// MARK: Properties
	dynamic var name: String = ""
	dynamic var yearsPlayed: Int = 0 // calculate time played from a given date
	dynamic var biography: String? = nil
	dynamic var location: String = ""
	var favoritedEvents = List<Event>()
	var friends = List<ViewableAccount>()
	
	// MARK: Life Cycle
	convenience init (name: String, location: String, yearsPlayed: Int) {
		self.init()
		self.name = name
		self.location = location
		self.yearsPlayed = yearsPlayed
	}
	
	// MARK: Private
	
	// MARK: Public
}
