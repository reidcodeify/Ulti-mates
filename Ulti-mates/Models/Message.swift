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
	var from: ActiveAccount
	var to: ViewableAccount
	var date: NSDate
	var body: String
	
	// MARK: Life Cycle
	init (from: ActiveAccount, to: ViewableAccount, date: NSDate) {
		self.from = from
		self.to = to
		self.date = date
		self.body = ""
	}
	
	// MARK: Private
	
	
	// MARK: Public
	mutating func updateBody(body: String) {
		self.body = body
	}
}
