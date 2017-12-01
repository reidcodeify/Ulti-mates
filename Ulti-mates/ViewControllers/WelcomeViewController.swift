//
//  WelcomeViewController.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 7/24/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class

class WelcomeViewController: UIViewController {
	
	// MARK: Properties
	
	fileprivate let identifier: String = "WelcomeViewController"
	
	fileprivate var viewModel: WelcomeViewModel
	
	let welcomeLabel: UILabel = {
		let label = UILabel()
		label.text = "Welcome to Ulti-mates."
		label.font = UIFont.systemFont(ofSize: 26)
		label.textColor = .white
		return label
	}()
	
	let facebookLogInButton: UIButton = {
		let button = UIButton(type: UIButtonType.system)
		button.setTitle("Log in with Facebook", for: .normal)
		button.setTitleColor(.blue, for: .normal)
		button.layer.borderColor = UIColor.white.cgColor
		button.backgroundColor = .white
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 25
		button.addTarget(self, action: #selector(facebookButtonHit(_:)), for: .touchUpInside)
		return button
	}()
	
	let createButton: UIButton = {
		let button = UIButton(type: UIButtonType.system)
		button.setTitle("Create account", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 25
		button.layer.borderWidth = 1
		button.layer.borderColor = UIColor.white.cgColor
		return button
	}()
	
	let logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: "Logo Closed")?.withRenderingMode(.alwaysTemplate)
		imageView.tintColor = .white
		
		return imageView
	}()
	
	// MARK: Life Cycle
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Custom initializer that takes a viewModel
	///
	/// - Parameter viewModel: An instance of WelcomeViewModel
	init(viewModel: WelcomeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	deinit { print(identifier + " dismissed") }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.backgroundColor = .blue

		UIApplication.shared.statusBarStyle = .lightContent
		
		// Set up UINavigationController
		setUpUINavigationController()

		view.addSubview(logoImageView)
		view.addSubview(welcomeLabel)
		view.addSubview(facebookLogInButton)
		view.addSubview(createButton)
		
		view.addConstraintsWithFormat(format: "H:|-20-[v0(50)]", views: logoImageView)
		view.addConstraintsWithFormat(format: "H:|-20-[v0]", views: welcomeLabel)
		view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: facebookLogInButton)
		view.addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: createButton)
		view.addConstraintsWithFormat(format: "V:[v0(50)]-20-[v1(50)]", views: facebookLogInButton, createButton)
		
		NSLayoutConstraint(item: welcomeLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 0.6, constant: 0).isActive = true
		NSLayoutConstraint(item: logoImageView, attribute: .bottom, relatedBy: .equal, toItem: welcomeLabel, attribute: .top, multiplier: 1, constant: -30).isActive = true
		NSLayoutConstraint(item: facebookLogInButton, attribute: .top, relatedBy: .equal, toItem: welcomeLabel, attribute: .bottom, multiplier: 1, constant: 45).isActive = true
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	
	/// Pushes LogInViewController in
	@objc fileprivate func logInButtonHit(_ sender: UIBarButtonItem) {
		
	}
	
	/// Handles sign in from facebook
	@objc fileprivate func facebookButtonHit(_ sender: UIButton) {
		
	}
	
	/// Pushes CreateAccountViewController in
	@IBAction func createAccountButtonHit(_ sender: UIButton) {
		
	}
	
	// MARK: Private
	
	fileprivate func setUpUINavigationController() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in", style: .plain, target: self, action: #selector(logInButtonHit(_:)))
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = true
		navigationController?.view.backgroundColor = .clear
	}
	
	

	// MARK: Public

}
	
