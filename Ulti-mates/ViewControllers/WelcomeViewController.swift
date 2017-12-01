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
	
	let welcomeLabel: UILabel = {
		let label = UILabel()
		label.text = "Welcome to Ulti-mates."
		label.font = UIFont.systemFont(ofSize: 26)
		return label
	}()
	
	let facebookLogInButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = button.frame.height/2
		button.addTarget(self, action: #selector(facebookButtonHit(_:)), for: .touchUpInside)
		return button
	}()
	
	let createButton: UIButton = {
		let button = UIButton()
		button.layer.cornerRadius = button.frame.height/2
		button.layer.borderWidth = 1
		button.layer.borderColor = UIColor.white.cgColor
		return button
	}()
	
	let logoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFill
		imageView.image = UIImage(named: "Logo Closed")
		return imageView
	}()
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	fileprivate var viewModel: WelcomeViewModel
	
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

		UIApplication.shared.statusBarStyle = .lightContent
		
		// Set up UINavigationController
		setUpUINavigationController()

		view.addSubview(logoImageView)
		view.addConstraintsWithFormat(format: "H:|-20-[v0(50)]", views: logoImageView)
		view.addConstraintsWithFormat(format: "V:|-105-[v0(50)]", views: logoImageView)
		view.addConstraintsWithFormat(format: "V:|-140-[v0(50)]", views: welcomeLabel)
		view.addConstraintsWithFormat(format: "H:|-20-[v0]", views: welcomeLabel)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	
	/// Pushes CreateAccountViewController in
	@IBAction func createAccountButtonHit(_ sender: UIButton) {
		
	}
	
	// MARK: Private
	
	fileprivate func setupViews() {
		
	}
	
	fileprivate func setUpUINavigationController() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in", style: .plain, target: self, action: #selector(logInButtonHit(_:)))
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
		navigationController?.navigationBar.shadowImage = UIImage()
		navigationController?.navigationBar.isTranslucent = true
		navigationController?.view.backgroundColor = .clear
	}
	
	/// Pushes LogInViewController in
	@objc fileprivate func logInButtonHit(_ sender: UIBarButtonItem) {
		
	}
	
	/// Handles sign in from facebook
	@objc fileprivate func facebookButtonHit(_ sender: UIButton) {
		
	}

	// MARK: Public

}
	
