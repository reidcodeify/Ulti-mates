//
//  WelcomeViewModel2.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 7/24/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Class
class WelcomeViewModel {
	// MARK: Properties
	var realm: Realm
	
	// MARK: Life Cycle
	init (realm: Realm) {
		self.realm = realm
	}
	
	// MARK: Private
	
	// MARK: Public
	func accountDoesNotExist(emailToCheck email: String, nameToCheck name: String) -> Bool {
		for tempAccount in realm.objects(ActiveAccount.self) {
			if (tempAccount.name == name && tempAccount.email == email) {
				print("Account exists")
				return false
			}
		}
		return true
	}
	
	func fetchExistingAccount(withEmail email: String, withName name: String) -> ActiveAccount? {
		for tempAccount in realm.objects(ActiveAccount.self) {
			if (tempAccount.name == name && tempAccount.email == email) {
				print("Account exists")
				return tempAccount
			}
		}
		DLog("Error: Could not find account")
		return nil
	}
}
