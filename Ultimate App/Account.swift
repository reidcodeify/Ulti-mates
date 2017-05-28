//
//  Account.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// Global DataStore of Accounts
var dataStore: DataStoreModel = DataStoreModel()

// MARK: Struct
class Account {
	// MARK: Properties
	fileprivate(set) dynamic var name: String
	fileprivate(set) dynamic var email: String
	fileprivate(set) dynamic var password: String
	fileprivate(set) dynamic var zipcode: String
	fileprivate(set) dynamic var yearsPlayed: String
	fileprivate(set) dynamic var biography: String?
	fileprivate(set) var favoriteEvents: [Event]?
	
	// MARK: Life Cycle
	init (name: String, email: String, password: String, zipcode: String, yearsPlayed: String) {
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
