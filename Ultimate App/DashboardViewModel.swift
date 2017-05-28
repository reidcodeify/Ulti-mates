//
//  DashboardViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation

// MARK: Protocol
protocol Dashbordable {
	var activeAccount: Account { get set }
}

// MARK: Class
class DashboardViewModel: Dashbordable {
	// MARK: Properties
	var activeAccount: Account
	
	// MARK: Life Cycle
	init (account: Account) {
		activeAccount = account
	}
	
	// MARK: Private
	
	// MARK: Public
}
