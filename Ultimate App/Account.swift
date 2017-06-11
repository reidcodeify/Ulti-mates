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

/*
	create protocol for accounts "AccountIdentifiable" break it up:
		- activeAccount
		- otherAccount (for display only)
*/
protocol AccountIdentifiable {
	var name: String { get }
	var yearsPlayed: String { get }
	var zipcode: String { get }
	var biography: String? { get }
}

// MARK: Struct
class Account: Object, AccountIdentifiable {
	// MARK: Properties
	dynamic var name: String = ""
	dynamic var email: String = ""
	dynamic var password: String = ""
	dynamic var zipcode: String = ""
	dynamic var yearsPlayed: String = "" // calculate time played from a given date
	dynamic var biography: String? = nil
	var favoriteEvents = List<Event>()
	
	// MARK: Life Cycle
	convenience init (name: String, email: String, password: String, zipcode: String, yearsPlayed: String) {
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
	
	func updateYearsPlayed(yearsPlayed: String) {
		self.yearsPlayed = yearsPlayed
	}
}
