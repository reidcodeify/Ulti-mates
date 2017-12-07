//
//  SelectedEventViewModel.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/22/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Class
class SelectedEventViewModel {
	// MARK: Properties
	var event: Event
	var activeAccount: ActiveAccount
	
	// MARK: Life Cycle
	
	/// Initializer that takes an event and an activeAccount
	///
	/// - Parameter event: An instance of Event
	/// - Parameter activeAccount: An instance of ActiveAccount
	init(event: Event, activeAccount: ActiveAccount) {
		self.event = event
		self.activeAccount = activeAccount
	}
	
	// MARK: Private
	
	// MARK: Public
	
	/// Adds the player to the local event's activePlayerList and removes them from the maybePlayerList if they were previously there
	func playerIsAttending() {
		if (event.maybePlayers.contains(activeAccount)) {
			try! event.realm?.write {
				event.maybePlayers.remove(at: event.maybePlayers.index(of: activeAccount)!)
			}
		}
		
		try! event.realm?.write {
			event.activePlayers.append(activeAccount)
		}
	}
	
	/// Adds the player to the local event's maybePlayerList and removes them from the activePlayerList if they were previously there
	func playerIsPossiblyAttending() {
		if (event.activePlayers.contains(activeAccount)) {
			try! event.realm?.write {
				event.activePlayers.remove(at: event.activePlayers.index(of: activeAccount)!)
			}
		}
		
		try! event.realm?.write {
			event.maybePlayers.append(activeAccount)
		}
	}
	
	/// Returns a value for determining which segment should be selected
//	func determineSegment() -> Int {
//		
//	}
}
