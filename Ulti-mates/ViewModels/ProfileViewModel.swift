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
	init (realm: Realm, activeAccount: ActiveAccount) {
		self.realm = realm
		self.activeAccount = activeAccount
	}
}
