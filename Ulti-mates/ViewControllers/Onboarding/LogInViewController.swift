//
//  LogInViewController.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 7/24/17.
//  Copyright © 2017 Codeify. All rights reserved.
//	
//	Forward button filled from "https://icons8.com/icon/26196/Forward-Button-Filled"
//

import UIKit

// MARK: Class
class LogInViewController: UIViewController {
	// MARK: Properties
	fileprivate let identifier: String = "LogInViewController"
	
	@IBOutlet fileprivate weak var logInLabel: UILabel!
	@IBOutlet fileprivate weak var emailTextField: UITextField!
	@IBOutlet fileprivate weak var showButton: UIButton!
	@IBOutlet fileprivate weak var passwordTextField: UITextField!
	@IBOutlet fileprivate weak var proceedButton: UIButton!
	
	fileprivate var viewModel: LogInViewModel
	
	// MARK: Life Cycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	init(viewModel: LogInViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up Self
		hideKeyboardWhenScreenTapped()
		
		// Set up UINavigationController
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Forgot password", style: .plain, target: self, action: #selector(forgotPasswordBarButtonHit(_:)))
		
		// Set up UILabel
		logInLabel.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 40).isActive = true
		
		// Set up UITextFields
		emailTextField.setBottomLine(borderColor: .white)
		passwordTextField.setBottomLine(borderColor: .white)
		emailTextField.tintColor = .white
		passwordTextField.tintColor = .white
		emailTextField.autocorrectionType = .no
		
		// Set up UIButton
		proceedButton.isEnabled = false
		
		// Updatable Properties
		viewModel.canContinue.bind { canContinue in
			self.proceedButton.isEnabled = canContinue
		}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: Control Handlers
	
	/// Updates the respective local variable (email or password) with the respective UITextField
	@IBAction func textFieldChanged(_ sender: UITextField) {
		switch sender {
			case emailTextField:
				viewModel.updateEmail(email: sender.text!)
			case passwordTextField:
				viewModel.updatePassword(password: sender.text!)
			default: break
		}
		viewModel.checkRequirements()
	}
	
	/// Switches the passwordTextField's value for secureTextEntry
	@IBAction func showButtonHit(_ sender: UIButton) {
		let title = (passwordTextField.isSecureTextEntry) ? "Hide" : "Show"
		showButton.setTitle(title, for: .normal)
		passwordTextField.isSecureTextEntry = (passwordTextField.isSecureTextEntry) ? false : true
	}
	
	/// Takes the user to DashboardViewController
	@IBAction func proceedButtonHit(_ sender: UIButton) {
		// if the credentials are valid, then proceed. otherwise present an error
		if let account = viewModel.authenticateCredentials() {
			let viewModel = DashboardViewModel(realm: self.viewModel.realm, account: account)
			let rootVC = UIViewController()
			rootVC.setInitialViewController(DashboardTabBarViewController(viewModel: viewModel))
			self.view.window?.rootViewController = rootVC
			self.view.window?.makeKeyAndVisible()
		} else {
			let alert = UIAlertController(title: "These credentials don't look right", message: "Try again", preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
			DLog("Error, Could not authenticate these log-in credentials")
		}
	}
	
	// MARK: Private
	@objc fileprivate func forgotPasswordBarButtonHit(_ sender: UIBarButtonItem) {
		
	}
	
	// MARK: Public

}
