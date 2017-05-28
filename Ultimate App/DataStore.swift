//
//  DataStore.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Class
struct DataStoreModel {
	// MARK: Properties
	internal var data: [Account]?
	
	// MARK: Life Cycle
	init () {
		self.data = []
	}
}
