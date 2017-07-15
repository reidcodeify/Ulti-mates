//
//  SignUpView.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/29/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class
class SignUpView: UIView {
	// MARK: Properties
	fileprivate let identifier: String = "SignUpView"
	
	@IBOutlet fileprivate weak var nameTextField: UITextField!
	@IBOutlet fileprivate weak var emailTextField: UITextField!
	@IBOutlet fileprivate weak var passwordTextField: UITextField!
	
	fileprivate var viewModel: SignUpViewModel
	
	// MARK: Life Cycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Custom initializer that takes a frame and viewModel
	///
	/// - Parameter frame: A CGRect of the calling-UIScrollView's content size
	/// - Parameter viewModel: An instance of SignUpViewModel
	init(frame: CGRect, viewModel: SignUpViewModel) {
		self.viewModel = viewModel
		super.init(frame: frame)
		self.setUp()
	}
	
	deinit {}
	
	// MARK: Control Handlers
	
	/// Updates the viewModel's properties with respect to the edited UITextField
	/// 
	/// - Parameter sender: The UITextField that that the user entered text into
	@IBAction func textFieldChanged(_ sender: UITextField) {
		switch sender.tag {
		case 0:
			viewModel.updateName(name: sender.text!)
		case 1:
			viewModel.updateEmail(email: sender.text!)
		case 2:
			viewModel.updatePassword(password: sender.text!)
		default:
			break
		}
		
		self.viewModel.checkRequirements()
	}
	
	// MARK: Private 
	fileprivate func setUp() {
		// Set up UINib
		var nibView: UIView! = nil
		nibView = Bundle(for: type(of: self)).loadNibNamed(identifier, owner: self, options: nil)![0] as! UIView
		nibView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(nibView)
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": nibView]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": nibView]))
		
		// Set up UITextFields
		nameTextField.indentUnderlineAndTint(placeholder: "Name")
		emailTextField.indentUnderlineAndTint(placeholder: "Email")
		passwordTextField.indentUnderlineAndTint(placeholder: "Password")
	}
	
	// MARK: Public 

}
