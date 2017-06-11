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
	@IBOutlet fileprivate weak var nameTextField: UITextField!
	@IBOutlet fileprivate weak var emailTextField: UITextField!
	@IBOutlet fileprivate weak var passwordTextField: UITextField!
	@IBOutlet fileprivate weak var zipcodeTextField: UITextField!
	@IBOutlet fileprivate weak var yearsPlayedTextField: UITextField!
	
	fileprivate var nibView: UIView! = nil
	fileprivate var viewModel: SignUpViewModel! = nil
	
	// MARK: Life Cycle
	init(frame: CGRect, viewModel: SignUpViewModel) {
		super.init(frame: frame)
		self.viewModel = viewModel
		nibView = Bundle(for: type(of: self)).loadNibNamed("SignUpView", owner: self, options: nil)![0] as! UIView
		nibView.translatesAutoresizingMaskIntoConstraints = false
		addSubview(nibView)
		
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": nibView]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": nibView]))
		
		nameTextField.indentAndUnderline()
		emailTextField.indentAndUnderline()
		passwordTextField.indentAndUnderline()
		zipcodeTextField.indentAndUnderline()
		yearsPlayedTextField.indentAndUnderline()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Control Handlers
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
		
		self.viewModel.checkRequirements()
	}
	
	// MARK: Private 
	
	// MARK: Public 

}
