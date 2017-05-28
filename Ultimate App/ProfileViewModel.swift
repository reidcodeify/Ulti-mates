//
//  ProfileViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation

// MARK: Protocol
protocol Profilable {
	var account: Account { get set }
}

// MARK: Class
class ProfileViewModel: Profilable {
	// MARK: Properties
	var account: Account
	
	// MARK: Life Cycle
	init (account: Account) {
		self.account = account
	}
}
