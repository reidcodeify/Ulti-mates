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
	var event: Event

	// make a value for determining the color state of the event
	var isAttending: Bool?
	
	// MARK: Life Cycle
	init (realm: Realm, event: Event) {
		self.realm = realm
		self.event = event
	}
	
	// MARK: Private
	
	// MARK: Public
	func setAttending(isAttending: Bool) {
		self.isAttending = isAttending
	}
	
	func updatePlayerCount(amountToAdd: Int) {
		if (event.players.count == 0 && amountToAdd == -1) {} else { // make sure players.count is not 0, otherwise updatePlayerCount
			do {
				try realm.write {
					//event.players.append(<#T##newElement: Account##Account#>)
				}
			} catch {
				DLog("Could not update player count bro")
			}
		}
	}
}
