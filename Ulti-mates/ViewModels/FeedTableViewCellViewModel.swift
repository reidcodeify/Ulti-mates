//
//  FeedTableViewCellViewModel.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/13/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Class
class FeedTableViewCellViewModel {
	// MARK: Properties
	var realm: Realm
	var activeAccount: ActiveAccount
	var event: Event

	// make a value for determining the color state of the event
	var isActive = UpdatableProperty<Bool>(value: false)
	
	// MARK: Life Cycle
	init (realm: Realm, activeAccount: ActiveAccount, event: Event) {
		self.realm = realm
		self.activeAccount = activeAccount
		self.event = event
	}
	
	// MARK: Private
	
	// MARK: Public
	func setActiviteState(isActive: Bool) {
		self.isActive.value = isActive
	}
	
	func updatePlayerCount(shouldAdd: Bool) {
		if (shouldAdd == true && !event.players.contains(activeAccount)) {
			try! realm.write {
				event.players.append(activeAccount)
			}
		} else if (shouldAdd == false && event.players.contains(activeAccount)) {
			try! realm.write {
				event.players.remove(objectAtIndex: event.players.index(of: activeAccount)!)
			}
		}
	}
}
