//
//  SignInViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/20/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation

// MARK: Protocol
protocol SignInable {
	var email: String { get set }
	var password: String { get set }
	
	func updateEmail(email: String) -> Void
	func updatePassword(password: String) -> Void
	func authenticateCredentials() -> Account?
}

// MARK: Class
class SignInViewModel: SignInable {
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
		for account in dataStore.data! {
			if (account.email == email && account.password == password) {
				return account
			}
		}
		
		// Handle inability to log in (Alert View controller?)
		DLog("Account not found")
		return nil
	}
}
