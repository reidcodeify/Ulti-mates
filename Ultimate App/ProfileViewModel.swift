//
//  ProfileViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Protocol
protocol Profilable {
	var account: Account { get set }
}

// MARK: Class
class ProfileViewModel: Profilable {
	// MARK: Properties
	var realm: Realm
	var account: Account
	
	// MARK: Life Cycle
	init (realm: Realm, account: Account) {
		self.realm = realm
		self.account = account
	}
}
