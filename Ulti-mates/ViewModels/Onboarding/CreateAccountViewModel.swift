//
//  CreateAccountViewModel.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 7/26/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Enum
enum CreateAccountState {
	case name
	case email
	case password
}

// MARK: Class
class CreateAccountViewModel {
	// MARK: Properties
	var realm: Realm
	var state: CreateAccountState = .name
	
	var firstName: String = ""
	var lastName: String = ""
	var email: String = ""
	var password: String = ""
	
	var nameCanContinue = UpdatableProperty<Bool>(value: false)
	var emailCanContinue = UpdatableProperty<Bool>(value: false)
	var passwordCanContinue = UpdatableProperty<Bool>(value: false)
	
	// MARK: Life Cycle
	init (realm: Realm) {
		self.realm = realm
	}
	
	// MARK: Private
	
	// MARK: Public
	
	/// Updates the local value of firstName with the most recently entered value from firstNameTextField
	func updateFirstName(firstName: String) {
		self.firstName = firstName
	}
	
	/// Updates the local value of lastName with the most recently entered value from lastNameTextField
	func updateLastName(lastName: String) {
		self.lastName = lastName
	}
	
	/// Updates the local value of email with the most recently entered value from emailTextField
	func updateEmail(email: String) {
		self.email = email
	}
	
	/// Updates the local value of password with the most recently entered value from passwordTextField
	func updatePassword(password: String) {
		self.password = password
	}
	
	/// Updates the local value of state with the current state the user is on
	func updateState(state: CreateAccountState) {
		self.state = state
	}
	
	/// Asserts whether both name properties have been sufficiently completed
	func checkNameRequirements() {
		if (firstName.isEmpty || lastName.isEmpty) {
			nameCanContinue.update(false)
		} else {
			nameCanContinue.update(true)
		}
	}
	
	/// Asserts whether or not the email property has been sufficiently completeed
	func checkEmailRequirements() {
		if (!email.contains("@") || !email.contains(".")) {
			emailCanContinue.update(false)
		} else {
			emailCanContinue.update(true)
		}
	}
	
	/// Asserts whether or not the password property has been sufficiently completed
	func checkPasswordRequirements() {
		if (password.characters.count < 7) {
			passwordCanContinue.update(false)
		} else {
			passwordCanContinue.update(true)
		}
	}
	
	/// Writes to realm with the information supplied by the user when completing CreateAccountViewController
	func createAccount() -> ActiveAccount {
		let newAccount = ActiveAccount(name: firstName, email: email, password: password)
		try! realm.write {
			realm.add(newAccount)
		}
		
		return newAccount
	}
	
	/// Checks if the currently entered email already exists in the local realm storage
	func emailPreexists() -> Bool {
		for account in realm.objects(ActiveAccount.self) {
			if (self.email == account.email) {
				return true // Email exists
			}
		}
		// Email is new
		return false
	}
}
