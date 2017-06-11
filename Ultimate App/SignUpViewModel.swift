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
	fileprivate(set) var canContinue = UpdatableProperty<Bool>(value: false)
	
	// MARK: Life Cycle
	init () {
		
	}
	
	// MARK: Public
	// canContinue's value becomes true if all of this class' String properties contain at least one character, the email property contains ('@' and '.'), and the password is at least 6 characters
	func checkRequirements() {
		if (!name.isEmpty && email.contains("@") && email.contains(".") && password.characters.count >= 6 && !zipcode.isEmpty && !yearsPlayed.isEmpty) {
			canContinue.value = true
		} else {
			canContinue.value = false
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
