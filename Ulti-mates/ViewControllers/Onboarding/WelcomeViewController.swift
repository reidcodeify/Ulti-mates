//
//  WelcomeViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/28/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class
class WelcomeViewController: UIViewController {
	// MARK: Properties
	fileprivate let identifier: String = "WelcomeViewController"
	
	@IBOutlet fileprivate weak var scrollView: UIScrollView!
	@IBOutlet fileprivate weak var continueButton: UIButton!
	@IBOutlet fileprivate weak var signUpButton: UIButton!
	@IBOutlet fileprivate weak var logInButton: UIButton!
	@IBOutlet fileprivate weak var selectionLine: UIView!
	@IBOutlet fileprivate weak var selectionLineCenter: NSLayoutConstraint!
	
	fileprivate var viewModel: WelcomeViewModel
	
	// MARK: Life Cycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Custom initializer that takes a viewModel
	///
	/// - Parameter viewModel: An instance of WelcomeViewModel
	init (viewModel: WelcomeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	deinit { print(identifier + " dismissed") }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Set up UIViewController
		self.hideKeyboardWhenScreenTapped()
		
		// Set up UIButton
		continueButton.roundAndShadow()
		
		// Set up UIScrollView
		let signUpView = SignUpView(frame: scrollView.bounds, viewModel: viewModel.signUpViewModel)
		let logInView = LogInView(frame: scrollView.bounds, viewModel: viewModel.logInViewModel)
		let views: [UIView] = [signUpView, logInView]
		
		var previousView: UIView? = nil
		var index = 0
		for pageView in views {
			pageView.translatesAutoresizingMaskIntoConstraints = false
			
			scrollView.addSubview(pageView)
			
			if let previous = previousView {
				scrollView.addConstraint(NSLayoutConstraint(item: pageView, attribute: .leading, relatedBy: .equal, toItem: previous, attribute: .trailing, multiplier: 1, constant: 0))
			} else {
				scrollView.addConstraint(NSLayoutConstraint(item: pageView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: 0))
			}
			
			scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[view]-(0)-|", options: [], metrics: nil, views: ["view": pageView]))
			scrollView.addConstraint(NSLayoutConstraint(item: pageView, attribute: .width, relatedBy: .equal, toItem: scrollView, attribute: .width, multiplier: 1, constant: 0))
			scrollView.addConstraint(NSLayoutConstraint(item: pageView, attribute: .height, relatedBy: .equal, toItem: scrollView, attribute: .height, multiplier: 1, constant: 0))
			
			if index == (views.count - 1) {
				scrollView.addConstraint(NSLayoutConstraint(item: pageView, attribute: .trailing, relatedBy: .equal, toItem: scrollView, attribute: .trailing, multiplier: 1, constant: 0))
			} else {
				previousView = pageView
			}
			
			index += 1
		}
		
		// Updatable properties
		viewModel.signUpViewModel.canContinue.bind { [weak self] canContinue in
			self?.continueButton.isEnabled = canContinue
			
			// when canContinue is true, do a cool red-fill effect on the continueButton to declare that it's enabled. Do a reverse effect when canContinue is false
			let color = (canContinue) ? UIColor.darkText : UIColor.lightText
			self?.continueButton.setTitleColor(color, for: .normal)
		}
		
		viewModel.logInViewModel.canContinue.bind { [weak self] canContinue in
			self?.continueButton.isEnabled = canContinue
		}
    }
	
	override func viewWillAppear(_ animated: Bool) {
		if (viewModel.viewState == .signUp) {
			selectionMade(signUpButton)
			viewModel.signUpViewModel.checkRequirements()
		} else {
			selectionMade(logInButton)
			viewModel.logInViewModel.checkRequirements()
		}
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	
	/// If the user is creating an account, then an account is added to the local realm storage.
	/// If the user is logging in, then their credentials are checked in the local realm storage by the viewModel. The user is presented their dashboard if successful
	///
	/// - Parameter sender: The UIButton that was tapped by the user
	@IBAction func continueButtonHit(_ sender: UIButton) {
		if (viewModel.viewState == .signUp) {
			let account: ActiveAccount = ActiveAccount(name: self.viewModel.signUpViewModel.name, email: self.viewModel.signUpViewModel.email, password: self.viewModel.signUpViewModel.password)
	
			if (viewModel.signUpViewModel.emailPreexists()) {
				let alert = UIAlertController(title: "Couldn't Create Account", message: "An account is already associated with this email", preferredStyle: UIAlertControllerStyle.alert)
				alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
				self.present(alert, animated: true, completion: nil)
				return
			}
			
			do {
				try self.viewModel.realm.write {
					self.viewModel.realm.add(account)
				}
				
				let viewModel = DashboardViewModel(realm: self.viewModel.realm, account: account)
				let tabController = DashboardTabBarViewController(viewModel: viewModel)
				parent?.fadeToChildViewController(tabController)
			} catch {
				DLog("Error. Could not write to the realm, bro")
			}
		} else {
			if let account = viewModel.logInViewModel.authenticateCredentials() {
				let viewModel = DashboardViewModel(realm: self.viewModel.realm, account: account)
				let tabController = DashboardTabBarViewController(viewModel: viewModel)
				parent?.fadeToChildViewController(tabController)
			} else {
				let alert = UIAlertController(title: "Couldn't Sign In", message: "Incorrect email or password", preferredStyle: UIAlertControllerStyle.alert)
				alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
				self.present(alert, animated: true, completion: nil)
				DLog("Error, Could not authenticate these log-in credentials")
			}
		}
	}
	
	/// Adjusts the user interface to match the corresponding selection made
	///
	/// - Parameter sender: The UIButton that was tapped by the user
	@IBAction func selectionMade(_ sender: UIButton) {
		var slidePosition: CGFloat
		
		if (sender.tag == 0) {
			slidePosition = 0
			viewModel.signUpViewModel.checkRequirements()
			viewModel.setViewState(viewState: .signUp)
			logInButton.setTitleColor(.lightGray, for: .normal)
			continueButton.setTitle("Create", for: .normal)
		} else {
			slidePosition = view.bounds.width
			viewModel.logInViewModel.checkRequirements()
			viewModel.setViewState(viewState: .logIn)
			signUpButton.setTitleColor(.lightGray, for: .normal)
			continueButton.setTitle("Continue", for: .normal)
		}
		
		sender.setTitleColor(.darkGray, for: .normal)
		selectionLineCenter.constant = (sender === signUpButton) ? 0 : view.bounds.midX
		UIView.animate(withDuration: 0.3, animations: {
			self.view.layoutIfNeeded()
			self.scrollView.contentOffset.x = slidePosition
		})
	}
	
	// MARK: Private
	
	// MARK: Public
	
}
