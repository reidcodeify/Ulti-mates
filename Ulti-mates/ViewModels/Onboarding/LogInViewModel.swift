//
//  SignInViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/20/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Class
class LogInViewModel {
	// MARK: Properties
	fileprivate(set) var realm: Realm
	fileprivate(set) var email: String = ""
	fileprivate(set) var password: String = ""
	fileprivate(set) var canContinue = UpdatableProperty<Bool>(value: false)
	
	// MARK: Life Cycle
	
	/// Initializer that takes a realm
	///
	/// - Parameter realm: An instance of Realm
	init (realm: Realm) {
		self.realm = realm
	}
	
	// MARK: Private
	
	// MARK: Public
	
	/// Takes a String, and sets it as the value of email
	///
	/// - Parameter email: The most recently updated text value of emailTextField
	func updateEmail(email: String) {
		self.email = email
	}
	
	/// Takes a String, and sets password's value with it
	///
	/// - Parameter password: The most recently edited text value of passwordTextField
	func updatePassword(password: String) {
		self.password = password
	}
	
	/// Enumerates through the local realm storage, checking to ensure that the entered credentials  do in-fact match a preexisting account
	///
	/// Returns an instance of ActiveAccount
	func authenticateCredentials() -> ActiveAccount? { // This would make a good unit test
		// If this account exists within the Realm storage, then proceed, otherwise deny access
		for account in realm.objects(ActiveAccount.self) {
			if (account.email == email && account.password == password) {
				canContinue.update(true)
				return account
			} else {
				canContinue.update(false)
			}
		}
		
		return nil
	}
	
	/// Updates whether or not the user may authenticate their credentials against the local realm storage
	///
	/// Assertions:
	/// * email contains @ and .
	/// * password's length is at least 6 characters long
	func checkRequirements() {
		if (email.contains("@") && email.contains(".") && password.characters.count >= 6) {
			canContinue.update(true)
		} else {
			canContinue.update(false)
		}
	}
}
