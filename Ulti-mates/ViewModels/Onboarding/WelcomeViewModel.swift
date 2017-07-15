//
//  WelcomeViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/29/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Enum
enum WelcomeState {
	case signUp
	case logIn
}

// MARK: Class
class WelcomeViewModel {
	// MARK: Properties
	let realm: Realm
	var signUpViewModel: SignUpViewModel
	var logInViewModel: LogInViewModel
	var viewState: WelcomeState = .signUp
	
	// MARK: Life Cycle
	init (realm: Realm, viewState: WelcomeState) {
		self.realm = realm
		self.signUpViewModel = SignUpViewModel(realm: self.realm)
		self.logInViewModel = LogInViewModel(realm: self.realm)
		self.viewState = viewState
	}
	
	deinit {}
		
	// MARK: Private
	
	// MARK: Public
	
	/// Takes a viewState and updates the value of local variable, viewState with it
	/// 
	/// - Parameter viewState: An instance of WelcomeState
	func setViewState(viewState: WelcomeState) {
		self.viewState = viewState
	}
}
