//
//  LogInView.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/29/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class
class LogInView: UIView {
	// MARK: Properties
	fileprivate let identifier: String = "LogInView"
	
	@IBOutlet fileprivate weak var emailTextField: UITextField!
	@IBOutlet fileprivate weak var passwordTextField: UITextField!
	@IBOutlet fileprivate weak var credentialSupportLabel: UILabel!
	fileprivate var nibView: UIView! = nil
	
	fileprivate var viewModel: LogInViewModel
	
    // MARK: Life Cycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Custom initializer that takes a frame  and a viweModel
	/// 
	/// - Parameter frame: A CGRect of the calling-UIScrollview's content size
	/// - Parameter viewModel: An instance of LogInViewModel
	init(frame: CGRect, viewModel: LogInViewModel) {
		self.viewModel = viewModel
		super.init(frame: frame)
		self.setUp()
	}
	
	deinit { print("LogInView dismissed") }
	
	// MARK: Control Handlers
	
	/// Updates the viewModel's property with respect to the edited UITextField
	///
	/// - Parameter sender: The UITextField that the user edited
	@IBAction func textFieldChanged(_ sender: UITextField) {
		switch sender.tag {
		case 0:
			viewModel.updateEmail(email: sender.text!)
		case 1:
			viewModel.updatePassword(password: sender.text!)
		default:
			break
		}
		viewModel.checkRequirements()
	}
	
	// MARK: Private
	
	/// Progresses through the default layout of LogInView
	fileprivate func setUp() {
		// Set up UINib
		nibView = Bundle(for: type(of: self)).loadNibNamed(identifier, owner: self, options: nil)![0] as! UIView
		nibView.awakeFromNib()
		nibView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(nibView)
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": nibView]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": nibView]))
		
		// Set up UITextFields
		emailTextField.indentUnderlineAndTint(placeholder: "Email")
		passwordTextField.indentUnderlineAndTint(placeholder: "Password")
	}
	
	// MARK: Public
}

// MARK: Extension
extension LogInView: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.endEditing(true)
		
		return true
	}
}
