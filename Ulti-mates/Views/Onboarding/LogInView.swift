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
	@IBOutlet fileprivate weak var emailTextField: UITextField!
	@IBOutlet fileprivate weak var passwordTextField: UITextField!
	@IBOutlet fileprivate weak var credentialSupportLabel: UILabel!
	
	fileprivate var nibView: UIView! = nil
	
	fileprivate var viewModel: LogInViewModel! = nil
	
    // MARK: Life Cycle
	init(frame: CGRect, viewModel: LogInViewModel) {
		super.init(frame: frame)
		self.viewModel = viewModel
		nibView = Bundle(for: type(of: self)).loadNibNamed("LogInView", owner: self, options: nil)![0] as! UIView
		nibView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(nibView)
		
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": nibView]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": nibView]))
		
		emailTextField.indentUnderlineAndTint(placeholder: "Email")
		passwordTextField.indentUnderlineAndTint(placeholder: "Password")
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
		viewModel.checkRequirements()
	}
	
	// MARK: Private
	
	// MARK: Public
}

extension LogInView: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.endEditing(true)
		
		return true
	}
}
