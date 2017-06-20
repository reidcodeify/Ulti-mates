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
	init (realm: Realm) {
		self.realm = realm
	}
	
	// MARK: Public
	func updateEmail(email: String) {
		self.email = email
	}
	
	func updatePassword(password: String) {
		self.password = password
	}
	
	func authenticateCredentials() -> Account? { // This would make a good unit test
		// If this account exists within the Realm storage, then proceed, otherwise deny access
		for account in realm.objects(Account.self) {
			if (account.email == email && account.password == password) {
				canContinue.value = true
				return account
			} else {
				canContinue.value = false
			}
		}
		
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
