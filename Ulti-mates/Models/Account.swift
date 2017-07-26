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
	var favoriteEvents: List<Event> { get }
	var friendsList: List<ViewableAccount> { get }
	var homeLocation: RealmPlace? { get }
}

// MARK: Class
class ActiveAccount: Object, Profilable {
	// MARK: Properties
	dynamic var uniqueIdentifier: Int = Int(arc4random())
	dynamic var name: String = ""
	dynamic var email: String = ""
	dynamic var password: String? = ""
	dynamic var homeLocation: RealmPlace? = nil
	var favoriteEvents = List<Event>()
	var friendsList = List<ViewableAccount>()
	
	// MARK: Life Cycle
	
	/// Initializer that takes a name, email, and a password
	///
	/// - Parameter name: An instance of String that holds the user's name
	/// - Parameter email: An instance of String that holds the user's email
	/// - Parameter password: An instance of String that holds the user's password
	convenience init (name: String, email: String, password: String?) {
		self.init()
		self.name = name
		self.email = email
		self.password = password
	}
	
	// MARK: Public
	
	/// Takes a name and updates the local value of name with it
	///
	/// - Parameter name: An instance of String
	func updateName(name: String) {
		self.name = name
	}
	
	/// Takes an email and updates the respective local value with it
	///
	/// - Parameter email: An instance of String
	func updateEmail(email: String) {
		self.email = email
	}
	
	/// Takes a password and updates the respective local value with it
	///
	/// - Parameter password: An instance of String
	func updatePassword(password: String) {
		self.password = password
	}
	
	func provideViewableAccount() -> ViewableAccount {
		return ViewableAccount(name: self.name, homeLocation: self.homeLocation!, friendsList: self.friendsList, favoriteEvents: self.favoriteEvents)
	}
}

// MARK: Class
class ViewableAccount: Object, Profilable {
	// MARK: Properties
	dynamic var name: String = ""
	dynamic var homeLocation: RealmPlace? = nil
	var favoriteEvents = List<Event>()
	var friendsList = List<ViewableAccount>()
	
	// MARK: Life Cycle
	
	/// Custom initializer that takes a name, homeLocation, friends-list and a password
	///
	/// - Parameter name: An instance of String that holds the user's name
	/// - Parameter homeLcoation: An instance of RealmPlace that holds the name, longitude, latitude, and placeID generated by the Google Maps APi
	/// - Parameter friends: An instance of List<ViewableAccount> that provides access to a user's friends-list
	/// - Parameter favoriteEvents: An instance of List<Event> that is a collection of a user's favorited events
	convenience init (name: String, homeLocation: RealmPlace, friendsList: List<ViewableAccount>, favoriteEvents: List<Event>) {
		self.init()
		self.name = name
		self.homeLocation = homeLocation
		self.friendsList = friendsList
		self.favoriteEvents = favoriteEvents
	}
	
	// MARK: Private
	
	// MARK: Public
}
