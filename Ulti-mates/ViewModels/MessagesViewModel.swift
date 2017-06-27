//
//  MessagesViewModel.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/16/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Class
class MessagesViewModel {
	// MARK: Properties
	var realm: Realm
	var activeAccount: ActiveAccount
	
	// MARK: Life Cycle
	init (realm: Realm, activeAccount: ActiveAccount) {
		self.realm = realm
		self.activeAccount = activeAccount
	}
	
	// MARK: Private
	
	// MARK: Public
}
