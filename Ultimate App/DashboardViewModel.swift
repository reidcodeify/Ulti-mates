//
//  DashboardViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Protocol
protocol Dashbordable {
	var activeAccount: ActiveAccount { get set }
}

// MARK: Class
class DashboardViewModel: Dashbordable {
	// MARK: Properties
	var realm: Realm
	var activeAccount: ActiveAccount
	
	// MARK: Life Cycle
	init (realm: Realm, account: ActiveAccount) {
		self.realm = realm
		activeAccount = account
	}
	
	// MARK: Private
	
	// MARK: Public
}
