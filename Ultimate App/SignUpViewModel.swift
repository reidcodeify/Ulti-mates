//
//  CreateAccountViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/20/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Class
class SignUpViewModel {
	// MARK: Properties
	fileprivate var realm: Realm
	fileprivate(set) var name: String = ""
	fileprivate(set) var email: String = ""
	fileprivate(set) var password: String = ""
	fileprivate(set) var zipcode: String = ""
	fileprivate(set) var yearsPlayed: String = ""
	fileprivate(set) var canContinue = UpdatableProperty<Bool>(value: false)
	
	// MARK: Life Cycle
	init (realm: Realm) {
		self.realm = realm
	}
	
	// MARK: Private
	
	// MARK: Public
	// canContinue's value becomes true if all of this class' String properties contain at least one character, the email property contains ('@' and '.'), and the password is at least 6 characters
	func checkRequirements() {
		if (!name.isEmpty && email.contains("@") && email.contains(".") && password.characters.count >= 6 && !zipcode.isEmpty && !yearsPlayed.isEmpty) {
			canContinue.value = true
		} else {
			canContinue.value = false
		}
	}
	
	func emailPreexists() -> Bool {
		for account in realm.objects(Account.self) {
			if (self.email == account.email) {
				return true // Email exists
			}
		}
		// Email is new
		return false
	}
	
	func updateName(name: String) {
		self.name = name
	}
	
	func updateEmail(email: String) {
		// check for preexisting email
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
