//
//  SignInViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/20/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation

// MARK: Class
class LogInViewModel {
	// MARK: Properties
	fileprivate(set) var email: String = ""
	fileprivate(set) var password: String = ""
	fileprivate(set) var canContinue = UpdatableProperty<Bool>(value: false)
	
	// MARK: Life Cycle
	init () {
		
	}
	
	// MARK: Public
	func updateEmail(email: String) {
		self.email = email
	}
	
	func updatePassword(password: String) {
		self.password = password
	}
	
	func authenticateCredentials() -> Account? { // This is a good unit test
		// If this account exists within the Realm storage, then proceed, otherwise deny access
		for account in ultimateRealm.objects(Account.self) {
			if (account.email == email && account.password == password) {
				canContinue.value = true
				return account
			} else {
				canContinue.value = false
			}
		}
		
		// Handle inability to log in (Alert View controller?)
		return nil
		

	}
	
	// The canContinue property becomes true if the email contains ('.' and an '@') and the password has a minimum character amount of 6
	func checkRequirements() {
		if (email.contains("@") && email.contains(".") && password.characters.count >= 6) {
			canContinue.value =  true
		} else {
			canContinue.value =  false
		}
	}
}
