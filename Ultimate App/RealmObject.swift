//
//  RealmObject.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/27/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

class RealmObject: Object {
	dynamic var count: Int = 0
	
	
	func incrementCount() {
		count += 1
	}
}
