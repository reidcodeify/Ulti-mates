//
//  CreateAccountViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/20/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation

// MARK: Protocol
protocol AccountCreatable {
	var name: String { get }
	var email: String { get }
	var password: String { get }
	var zipcode: String { get }
	var yearsPlayed: String { get }
	
	func updateName(name: String)
	func updateEmail(email: String)
	func updatePassword(password: String)
	func updateZipcode(zipcode: String)
	func updateYearsPlayed(yearsPlayed: String)
}

// MARK: Class
class CreateAccountViewModel: AccountCreatable {
	// MARK: Properties
	fileprivate(set) var name: String = ""
	fileprivate(set) var email: String = ""
	fileprivate(set) var password: String = ""
	fileprivate(set) var zipcode: String = ""
	fileprivate(set) var yearsPlayed: String = ""
	
	// MARK: Life Cycle
	init () {
		
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
	
	func updateYearsPlayed(yearsPlayed: String) {
		self.yearsPlayed = yearsPlayed
	}
}
