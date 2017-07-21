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
}
