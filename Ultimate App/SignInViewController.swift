//
//  SignInViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/20/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class
class SignInViewController: UIViewController {
	// MARK: Properties
	@IBOutlet fileprivate weak var emailTextField: UITextField!
	@IBOutlet fileprivate weak var passwordTextField: UITextField!
	
	fileprivate var viewModel: SignInViewModel = SignInViewModel()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboardWhenScreenTapped()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	@IBAction func textFieldChanged(_ sender: UITextField) {
		switch sender.tag {
		case 0:
			viewModel.updateEmail(email: sender.text!)
		case 1:
			viewModel.updatePassword(password: sender.text!)
		default:
			break
		}
	}
	
	@IBAction func signInButtonHit(_ sender: UIButton) {
		if let account = viewModel.authenticateCredentials() {
			let viewModel = DashboardViewModel(account: account)
			let navController = UINavigationController(rootViewController: DashboardTabBarViewController(viewModel: viewModel))
			
			parent?.fadeToChildViewController(navController)
		} else {
			DLog("Error, Could not sign in")
		}
	}
	
	// MARK: Private
	
	// MARK: Public
}
