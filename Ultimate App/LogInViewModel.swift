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
	var email: String = ""
	var password: String = ""
	
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
				return account
			}
		}
		
		// Handle inability to log in (Alert View controller?)
		DLog("Account not found")
		return nil
	}
}
