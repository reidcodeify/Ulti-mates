//
//  RealmLocation.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 7/11/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift
import GooglePlaces

// MARK: Class
class RealmPlace: Object {
	// MARK: Properties
	dynamic var name: String = ""
	dynamic var longtitude: Double = 0
	dynamic var latitude: Double = 0
	dynamic var placeID: String = ""
	
	// MARK: Life Cycle
	convenience init(withPlace place: GMSPlace) {
		self.init()
		self.name = place.name
		self.longtitude = place.coordinate.longitude
		self.latitude = place.coordinate.latitude
		self.placeID = place.placeID
	}
	
	// MARK: Private
	
	// MARK: Public
}
