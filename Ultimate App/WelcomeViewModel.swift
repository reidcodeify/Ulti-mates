//
//  WelcomeViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/29/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation

enum WelcomeState {
	case signUp
	case logIn
}

// MARK: Class
class WelcomeViewModel {
	// MARK: Properties
	var viewState: WelcomeState = .signUp
	var signUpViewModel: SignUpViewModel = SignUpViewModel()
	var logInViewModel: LogInViewModel = LogInViewModel()
	
		// view model for sign up (use updatable properties for data that matters to know when it changed) instantiate
		// view model for log in (use updatable properties for data that matters to know when it changed) instantiate 
	
	// MARK: Life Cycle
	init (viewState: WelcomeState) {
		self.viewState = viewState
	}
	
	// MARK: Control Handlers
	
	// MARK: Private
	
	// MARK: Public
}
