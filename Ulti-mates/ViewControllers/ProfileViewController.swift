//
//  ProfileViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class
class ProfileViewController: UIViewController {
	// MARK: Properties
	fileprivate var identifier: String = "ProfileViewController"

	@IBOutlet fileprivate weak var profileImage: UIImageView!
	@IBOutlet fileprivate weak var nameLabel: UILabel!

	fileprivate var viewModel: ProfileViewModel!
	
	// MARK: Life Cycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Custom initializer that takes a viewModel
	///
	/// - Parameter viewModel: An instance of ProfileViewModel
	init (viewModel: ProfileViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	deinit { print(identifier + " dismissed") }
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.hideKeyboardWhenScreenTapped()
		
		let moreButton = UIBarButtonItem(image: #imageLiteral(resourceName: "More"), style: .plain, target: self, action: #selector(moreButtonHit(_:)))
		navigationItem.rightBarButtonItem = moreButton
		
		profileImage.layer.borderWidth = 0.5
		profileImage.layer.cornerRadius = profileImage.frame.size.width/2
		profileImage.clipsToBounds = true
		nameLabel.text = viewModel.activeAccount.name
			
		profileImage.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 20).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: Control Handlers
	
	// MARK: Private
	
	/// Displays a UIAlertViewController with account-related options
	@objc fileprivate func moreButtonHit(_ sender: UIButton) {
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "Edit", style: .default) { action in
			// allow editing of information
			
		})
		alert.addAction(UIAlertAction(title: "Log out", style: .default) { [weak self] action in
			// sign the user out by taking away credentials from keychain, and transitioning to welcome view controller
			self?.tearDown()
		})
		alert.addAction(UIAlertAction(title: "Delete account", style: .default, handler: { [weak self] action in
			// delete account in viewModel and transition to welcomeviewController
			self?.viewModel.deleteAccount()
			self?.tearDown()
		}))
		alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	/// Removes all currently instantiated viewControllers from the UIWindow, and sets the rootViewController as WelcomeViewController
	fileprivate func tearDown() {
		let viewModel = WelcomeViewModel(realm: self.viewModel.realm, isSignUpState: false)
		let rootVC = UIViewController()
		rootVC.setInitialViewController(WelcomeViewController(viewModel: viewModel))
		self.view.window?.rootViewController = rootVC
		self.view.window?.makeKeyAndVisible()
	}
	
	// MARK: Public

}
