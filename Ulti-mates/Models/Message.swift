//
//  Message.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation

// MARK: Structure
struct Message {
	// MARK: Properties
	var sender: ActiveAccount
	var recipient: ViewableAccount
	var date: NSDate
	var body: String
	
	// MARK: Life Cycle
	
	/// Initializer that takes a sender, recipient, and a date sent
	///
	/// - Parameter sender: An instance of ActiveAccount that holds the message's sender
	/// - Parameter recipient: An instance of ViewableAccount that holds the information of the message's receiver
	/// - Parameter date: An instance of NSDate that holds the message's date of send
	init (sender: ActiveAccount, recipient: ViewableAccount, date: NSDate) {
		self.sender = sender
		self.recipient = recipient
		self.date = date
		self.body = ""
	}
	
	// MARK: Private
	
	// MARK: Public
	
	/// Takes a body and updates the respective local value with it
	///
	/// - Parameter body: An instance of String that represents the message's written content
	mutating func updateBody(body: String) {
		self.body = body
	}
}
