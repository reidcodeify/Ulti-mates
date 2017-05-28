//
//  Event.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

// MARK: Struct
class Event: Object {
	// MARK: Properties
	//var time
	fileprivate(set) var date: NSDate? = nil
	fileprivate(set) var desc: String = ""
	fileprivate(set) var maxPlayerCount: Int = 0
	fileprivate(set) var currentPlayerCount: Int = 0
	fileprivate(set) var image: UIImage? = nil
	fileprivate(set) var location: String = ""
	
	// MARK: Life Cycle
//	init (date: NSDate, description: String, maxPlayerCount: Int, currentPlayerCount: Int, image: UIImage, location: String) {
//		self.date = date
//		self.desc = description
//		self.maxPlayerCount = maxPlayerCount
//		self.currentPlayerCount = currentPlayerCount
//		self.image = image
//		self.location = location
//	}
	
	// MARK: Private
	
	// MARK: Public
	func updateDate(date: NSDate) {
		self.date = date
	}
	
	func updateDescription(description: String) {
		self.desc = description
	}
	
	func updateMaxPlayerCount(maxPlayerCount: Int) {
		self.maxPlayerCount = maxPlayerCount
	}
	
	func updateCurrentPlayerCount(currentPlayerCount: Int) {
		self.currentPlayerCount = currentPlayerCount
	}
	
	func updateImage(image: UIImage) {
		self.image = image
	}
	
	func updateLocation(location: String) {
		self.location = location
	}
}
