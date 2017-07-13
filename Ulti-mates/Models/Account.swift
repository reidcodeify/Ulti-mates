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
	var uniqueIdentifier: Int { get }
	var name: String { get }
	var favoritedEvents: List<Event> { get }
	var friends: List<ViewableAccount> { get }
	var location: String { get }
}

// MARK: Class
class ActiveAccount: Object, Profilable {
	// MARK: Properties
	dynamic var uniqueIdentifier: Int = Int(arc4random())
	dynamic var name: String = ""
	dynamic var email: String = ""
	dynamic var password: String = ""
	dynamic var location: String = ""
	var favoritedEvents = List<Event>()
	var friends = List<ViewableAccount>()
	
	// MARK: Life Cycle
	convenience init (name: String, email: String, password: String) {
		self.init()
		self.name = name
		self.email = email
		self.password = password
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
}

// MARK: Class
class ViewableAccount: Object, Profilable {
	// MARK: Properties
	dynamic var uniqueIdentifier: Int = Int(arc4random())
	dynamic var name: String = ""
	dynamic var yearsPlayed: Int = 0 // calculate time played from a given date
	dynamic var location: String = ""
	var favoritedEvents = List<Event>()
	var friends = List<ViewableAccount>()
	
	// MARK: Life Cycle
	convenience init (name: String, location: String) {
		self.init()
		self.name = name
		self.location = location
	}
	
	// MARK: Private
	
	// MARK: Public
}
