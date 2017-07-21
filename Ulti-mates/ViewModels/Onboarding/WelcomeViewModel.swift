//
//  WelcomeViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/29/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Class
class WelcomeViewModel {
	// MARK: Properties
	let realm: Realm
	var signUpViewModel: SignUpViewModel
	var logInViewModel: LogInViewModel
	var isSignUp: Bool = false
	
	// MARK: Life Cycle
	
	/// Initializer that takes a realm and viewState
	///
	/// - Parameter realm: An instance of Realm
	/// - Parameter viewState: An instance of WelcomeState
	init (realm: Realm, isSignUpState: Bool) {
		self.realm = realm
		self.signUpViewModel = SignUpViewModel(realm: self.realm)
		self.logInViewModel = LogInViewModel(realm: self.realm)
		self.isSignUp = isSignUpState
	}
	
	deinit {}
		
	// MARK: Private
	
	// MARK: Public
	
	/// Takes a viewState and updates the local value of viewState with it
	/// 
	/// - Parameter viewState: An instance of WelcomeState
	func setViewState(_ viewState: Bool) {
		self.isSignUp = viewState
	}
}
