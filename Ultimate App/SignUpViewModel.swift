//
//  CreateAccountViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/20/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation

// MARK: Class
class SignUpViewModel {
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
	func checkRequirements() -> Bool {
		if (!name.isEmpty && !email.isEmpty && !password.isEmpty && !zipcode.isEmpty && !yearsPlayed.isEmpty) {
			return true
		} else {
			return false
		}
	}
	
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
