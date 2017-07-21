//
//  ProfileViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Class
class ProfileViewModel {
	// MARK: Properties
	var realm: Realm
	var activeAccount: ActiveAccount
	
	// MARK: Life Cycle
	
	/// Initializer that takes a realm and an activeAccount
	///
	/// - Parameter realm: An instance of Realm
	/// - Parameter activeAccount: An instance of ActiveAccount
	init (realm: Realm, activeAccount: ActiveAccount) {
		self.realm = realm
		self.activeAccount = activeAccount
	}
	
	// MARK: Private
	
	// MARK: Public
	
	/// Attempts to remove the current activeAccount from the realm storage
	func deleteAccount() {
		do {
			try realm.write {
				realm.delete(activeAccount)
			}
		} catch (let error) {
			DLog("Error deleting ActiveAccount from Realm: \(error.localizedDescription)")
		}
	}
}
