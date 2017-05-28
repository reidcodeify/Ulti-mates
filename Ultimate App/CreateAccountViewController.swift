//
//  CreateAccountViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/20/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit
import RealmSwift

// MARK: Class
class CreateAccountViewController: UIViewController {
	// MARK: Properties
	@IBOutlet private weak var nameTextField: UITextField!
	@IBOutlet private weak var emailTextField: UITextField!
	@IBOutlet private weak var passwordTextField: UITextField!
	@IBOutlet private weak var zipcodeTextField: UITextField!
	
	private var viewModel: AccountCreatable = CreateAccountViewModel()
	
	// MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboardWhenScreenTapped()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	// MARK: Control Handlers
	@IBAction func createButtonHit(_ sender: UIButton) {
		// Create an account and add it to the local storage
		dataStore.data?.append(Account(name: viewModel.name, email: viewModel.email, password: viewModel.password, zipcode: viewModel.zipcode, yearsPlayed: viewModel.yearsPlayed))
		// Present Sign-in Screen
		parent?.fadeToChildViewController(SignInViewController())
	}
	
	@IBAction func textFieldChanged(_ sender: UITextField) {
		switch sender.tag {
		case 0:
			viewModel.updateName(name: sender.text!)
		case 1:
			viewModel.updateEmail(email: sender.text!)
		case 2:
			viewModel.updatePassword(password: sender.text!)
		case 3:
			viewModel.updateZipcode(zipcode: sender.text!)
		case 4:
			viewModel.updateYearsPlayed(yearsPlayed: sender.text!)
		default:
			break
		}
	}
	
	// MARK: Private
	
	// MARK: Public

	
}
