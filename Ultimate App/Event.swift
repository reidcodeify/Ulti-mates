//
//  Event.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import UIKit

// MARK: Struct
struct Event {
	// MARK: Properties
	//var time
	fileprivate(set) var date: NSDate
	fileprivate(set) var description: String
	fileprivate(set) var maxPlayerCount: Int
	fileprivate(set) var currentPlayerCount: Int
	fileprivate(set) var image: UIImage
	fileprivate(set) var location: String
	
	// MARK: Life Cycle
	init (date: NSDate, description: String, maxPlayerCount: Int, currentPlayerCount: Int, image: UIImage, location: String) {
		self.date = date
		self.description = description
		self.maxPlayerCount = maxPlayerCount
		self.currentPlayerCount = currentPlayerCount
		self.image = image
		self.location = location
	}
	
	// MARK: Private
	
	// MARK: Public
	mutating func updateDate(date: NSDate) {
		self.date = date
	}
	
	mutating func updateDescription(description: String) {
		self.description = description
	}
	
	mutating func updateMaxPlayerCount(maxPlayerCount: Int) {
		self.maxPlayerCount = maxPlayerCount
	}
	
	mutating func updateCurrentPlayerCount(currentPlayerCount: Int) {
		self.currentPlayerCount = currentPlayerCount
	}
	
	mutating func updateImage(image: UIImage) {
		self.image = image
	}
	
	mutating func updateLocation(location: String) {
		self.location = location
	}
}
