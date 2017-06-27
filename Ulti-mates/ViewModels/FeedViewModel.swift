//
//  FeedViewModel.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/11/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

// MARK: Enum
enum FeedState {
	case list
	case map
}

// MARK: Class
class FeedViewModel {
	// MARK: Properties
	var realm: Realm
	var activeAccount: ActiveAccount
	var events: [Event] = []
	var feedState = UpdatableProperty<FeedState>(value: .list)
	
	
	// MARK: Life Cycle
	init (realm: Realm, activeAccount: ActiveAccount) {
		self.realm = realm
		self.activeAccount = activeAccount
	}
	
	// MARK: Private
	
	// MARK: Public
	func updateFeedState(to feedState: FeedState) {
		self.feedState.value = feedState
	}
}
