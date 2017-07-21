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
	fileprivate(set) var name: String
	fileprivate(set) var email: String
	fileprivate(set) var password: String
	fileprivate(set) var canContinue: UpdatableProperty<Bool>
	
	// MARK: Life Cycle
	
	/// Initializer that takes a realm
	///
	/// - Parameter realm: An instance of Realm
	init (realm: Realm) {
		self.realm = realm
		self.name = ""
		self.email = ""
		self.password = ""
		self.canContinue = UpdatableProperty(value: false)
	}
	
	deinit {}
	
	// MARK: Private
	
	// MARK: Public
	
	/// Updates whether or not the user may authenticate their credentials against the local realm storage
	///
	/// Assertions:
	/// * email contains @ and .
	/// * password's length is at least 6 characters longand the password is at least 6 characters
	func checkRequirements() {
		if (!name.isEmpty && email.contains("@") && email.contains(".") && password.characters.count >= 6) {
			canContinue.update(true)
		} else {
			canContinue.update(false)
		}
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
	
	/// Takes a String, and sets it as the value of name
	///
	/// - Parameter name: The most recently updated text value of nameTextField
	func updateName(name: String) {
		self.name = name
	}
	
	/// Takes a String, and sets it as the value of email
	///
	/// - Parameter email: The most recently updated text value of emailTextField
	func updateEmail(email: String) {
		self.email = email
	}
	
	/// Takes a String, and attempts to set it as the value of password
	/// If the String is at least 6 characters long, then password's value is set with it
	///
	/// - Parameter password: The most recently edited text value of passwordTextField
	func updatePassword(password: String) -> String {
		self.password = password
		
		if (password.characters.count >= 6) {
			return ""
		} else {
			return "Password must contain at least 6 characters"
		}
	}
}
