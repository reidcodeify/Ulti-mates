//
//  LoginController.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 7/24/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit
import Firebase

// MARK: Class
class LoginController: UIViewController {
	
	// MARK: Properties
	fileprivate let identifier: String = "WelcomeViewController"
		
	let inputsContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.white
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 5
		view.layer.masksToBounds = true
		return view
	}()
	
	let loginRegisterButton: UIButton = {
		let button = UIButton(type: .system)
		button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
		button.setTitle("Register", for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.setTitleColor(.white, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
		
		button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
		
		return button
	}()
	
	func handleLoginRegister() {
		if (loginRegisterSegmentedControl.selectedSegmentIndex == 0) {
			handleLogin()
		} else {
			handleRegister()
		}
	}
	
	func handleLogin() {
		guard let email = emailTextField.text, let password = passwordTextField.text else {
			DLog("Form is not valud")
			return
		}
		
		Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
			if (error != nil) {
				DLog(error as! String)
				return
			}
			
			// successfully logged in our user
			self.dismiss(animated: true, completion: nil)
		}
	}
	
	func handleRegister() {
		guard let email = emailTextField.text, let password = passwordTextField.text,
		let name = nameTextField.text else {
			DLog("Form is not valud")
			return
		}
		
		Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error) in
			if (error != nil) {
				print(error!)
				return
			}
			
			guard let uid = user?.uid else {
				DLog("uid is invalid")
				return
			}
			
			// successfuly authenticated user
			let ref = Database.database().reference(fromURL: "https://ulti-mates-172617.firebaseio.com/")
			let usersReference = ref.child("users").child(uid)
			let values = ["name": name, "email": email]
			usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
				if (err != nil) {
					print(err!)
					return
				}
				
				self.dismiss(animated: true, completion: nil)
				
				print("Successfully saved user into Firebase DB")
			})
		}
	}
	
	let nameTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Name"
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.clipsToBounds = true
		return textField
	}()
	
	let nameSeparatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let emailTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Email"
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()
	
	let emailSeparatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	let passwordTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Password"
		textField.translatesAutoresizingMaskIntoConstraints = false
		textField.isSecureTextEntry = true
		return textField
	}()
	
	let welcomeLabel: UILabel = {
		let label = UILabel()
		label.text = "Ulti-mates"
		label.font = UIFont.boldSystemFont(ofSize: 26)
		label.textColor = .white
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	lazy var loginRegisterSegmentedControl: UISegmentedControl = {
		let sc = UISegmentedControl(items: ["Login", "Register"])
		sc.translatesAutoresizingMaskIntoConstraints = false
		sc.tintColor = .white
		sc.selectedSegmentIndex = 1
		sc.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
		return sc
	}()
	
	func handleLoginRegisterChange() {
		let title =  loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
		loginRegisterButton.setTitle(title, for: .normal)
		
		// change height of inputContainerView
		inputsContainerViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
		
		// change height of nameTextField
		nameTextFieldHeightAnchor?.isActive = false
		nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1/3)
		nameTextFieldHeightAnchor?.isActive = true
		
		// change height of emailTextField
		emailTextFieldHeightAnchor?.isActive = false
		emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
		emailTextFieldHeightAnchor?.isActive = true
		
		// change height of passwordTextField
		passwordTextFieldHeightAnchor?.isActive = false
		passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2 : 1/3)
		passwordTextFieldHeightAnchor?.isActive = true
	}
	
	// MARK: Life Cycle
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Custom initializer that takes a viewModel
	///
	/// - Parameter viewModel: An instance of WelcomeViewModel
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	deinit { print(identifier + " dismissed") }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
		
		view.addSubview(inputsContainerView)
		view.addSubview(loginRegisterButton)
		view.addSubview(welcomeLabel)
		view.addSubview(loginRegisterSegmentedControl)
		
		setupInputsContainerView()
		setupLoginRegisterButton()
		setupWelcomeLabel()
		setupLoginRegisterSegmentedControl()
	}

	
	// MARK: Control Handlers

	
	// MARK: Private
	
	fileprivate func setupLoginRegisterSegmentedControl() {
		loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
		loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true
	}
	
	fileprivate func setupWelcomeLabel() {
		welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		welcomeLabel.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -24).isActive = true
	}
	
	var inputsContainerViewHeightAnchor: NSLayoutConstraint?
	var nameTextFieldHeightAnchor: NSLayoutConstraint?
	var emailTextFieldHeightAnchor: NSLayoutConstraint?
	var passwordTextFieldHeightAnchor: NSLayoutConstraint?
	
	fileprivate func setupInputsContainerView() {
		inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
		inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 150)
		inputsContainerViewHeightAnchor?.isActive = true
		
		inputsContainerView.addSubview(nameTextField)
		inputsContainerView.addSubview(nameSeparatorView)
		inputsContainerView.addSubview(emailTextField)
		inputsContainerView.addSubview(emailSeparatorView)
		inputsContainerView.addSubview(passwordTextField)
		
		nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
		nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		nameTextFieldHeightAnchor = nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
		nameTextFieldHeightAnchor?.isActive = true
		
		nameSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
		nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
		nameSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		emailTextField.topAnchor.constraint(equalTo: nameSeparatorView.bottomAnchor).isActive = true
		emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		emailTextFieldHeightAnchor = emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
		emailTextFieldHeightAnchor?.isActive = true
		
		emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
		emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
		emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
		
		passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
		passwordTextField.topAnchor.constraint(equalTo: emailSeparatorView.bottomAnchor).isActive = true
		passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		passwordTextFieldHeightAnchor = passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3)
		passwordTextFieldHeightAnchor?.isActive = true
	}
	
	fileprivate func setupLoginRegisterButton() {
		loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
		loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
		loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	// MARK: Public

}
	
