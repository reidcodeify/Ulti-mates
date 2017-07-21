//
//  SelectedEventViewModel.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/22/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation

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
	
}
