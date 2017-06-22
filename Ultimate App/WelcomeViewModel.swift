//
//  WelcomeViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/29/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

enum WelcomeState {
	case signUp
	case logIn
}

// MARK: Class
class WelcomeViewModel {
	// MARK: Properties
	var viewState: WelcomeState = .signUp
	var signUpViewModel: SignUpViewModel
	var logInViewModel: LogInViewModel
	let realm: Realm
	
	// MARK: Life Cycle
	init (realm: Realm, viewState: WelcomeState) {
		self.realm = realm
		self.viewState = viewState
		signUpViewModel = SignUpViewModel(realm: self.realm)
		logInViewModel = LogInViewModel(realm: self.realm)
	}
	
	// MARK: Control Handlers
	
	// MARK: Private
	
	// MARK: Public
	func setViewState(viewState: WelcomeState) {
		self.viewState = viewState
	}
}
