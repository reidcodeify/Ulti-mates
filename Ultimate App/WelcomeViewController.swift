//
//  WelcomeViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/28/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

/*
	Create view-based xibs rather than controller-based xibs
	Make button for proceed
*/

// MARK: Class
class WelcomeViewController: UIViewController {
	// MARK: Properties
	@IBOutlet fileprivate weak var scrollView: UIScrollView!
	@IBOutlet fileprivate weak var continueButton: UIButton!
	@IBOutlet fileprivate weak var signUpButton: UIButton!
	@IBOutlet fileprivate weak var logInButton: UIButton!
	@IBOutlet fileprivate weak var selectionLine: UIView!
	
	fileprivate var viewModel: WelcomeViewModel! = nil
	
	// MARK: Life Cycle
	init (viewModel: WelcomeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: "WelcomeViewController", bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if (viewModel.viewState == .signUp) {
			selectionMade(signUpButton)
		} else {
			selectionMade(logInButton)
		}
		
		self.hideKeyboardWhenScreenTapped()
		continueButton.roundAndShadow()
	
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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	@IBAction func continueButtonHit(_ sender: UIButton) {
		if (viewModel.viewState == .signUp) {
			 //Create an account and add it to the local storage
			let account: Account = Account(name: self.viewModel.signUpViewModel.name, email: self.viewModel.signUpViewModel.email, password: self.viewModel.signUpViewModel.password, zipcode: self.viewModel.signUpViewModel.zipcode, yearsPlayed: self.viewModel.signUpViewModel.yearsPlayed)
	
			do {
				try ultimateRealm.write {
					ultimateRealm.add(account)
				}
				
				let viewModel = DashboardViewModel(account: account)
				let navController = UINavigationController(rootViewController: DashboardTabBarViewController(viewModel: viewModel))
				parent?.fadeToChildViewController(navController)
			} catch {
				DLog("Error. could not write to realm bro")
			}
		} else {
			// Present Sign-in Screen
			if let account = viewModel.logInViewModel.authenticateCredentials() {
				let viewModel = DashboardViewModel(account: account)
				let navController = UINavigationController(rootViewController: DashboardTabBarViewController(viewModel: viewModel))
				
				parent?.fadeToChildViewController(navController)
			} else {
				DLog("Error, Could not sign in bro")
			}
		}
	}
	
	@IBAction func selectionMade(_ sender: UIButton) {
		let buttonCenterToMatch = sender.center.x
		var slidePosition: CGFloat
		
		if (sender.tag == 0) {
			slidePosition = 0
			viewModel.viewState = .signUp
			continueButton.setTitle("Create", for: .normal)
		} else {
			slidePosition = view.bounds.width
			viewModel.viewState = .logIn
			continueButton.setTitle("Continue", for: .normal)
		}
		
		UIView.animate(withDuration: 0.3, animations: {
			self.selectionLine.center.x = buttonCenterToMatch
			self.scrollView.contentOffset.x = slidePosition
		})
	}
	
//	@IBAction func createButtonHit(_ sender: UIButton) {
//		// Create an account and add it to the local storage
//		let account = Account(name: viewModel.name, email: viewModel.email, password: viewModel.password, zipcode: viewModel.zipcode, yearsPlayed: viewModel.yearsPlayed)
//		
//		do {
//			try ultimateRealm.write {
//				ultimateRealm.add(account)
//			}
//		} catch {
//			// Handle the error that the realm could not be written to
//			DLog("Error. could not write to realm bro")
//		}
//		
//		// Present Sign-in Screen
//		parent?.fadeToChildViewController(SignInViewController())
//	}
	
//	@IBAction func signInButtonHit(_ sender: UIButton) {
//		if let account = viewModel.authenticateCredentials() {
//			let viewModel = DashboardViewModel(account: account)
//			let navController = UINavigationController(rootViewController: DashboardTabBarViewController(viewModel: viewModel))
//			
//			parent?.fadeToChildViewController(navController)
//		} else {
//			DLog("Error, Could not sign in")
//		}
//	}
	
	// MARK: Private
	
	
	// MARK: Public
	
}

extension WelcomeViewController: UIScrollViewDelegate {
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		print("\(scrollView.contentOffset.x)") // it's the left edge of current view
		
	}
}
