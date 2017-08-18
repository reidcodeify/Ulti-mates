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
	@IBOutlet fileprivate weak var eventsButton: UIButton!
	@IBOutlet fileprivate weak var friendsButton: UIButton!
	@IBOutlet fileprivate weak var selectionLineCenterX: NSLayoutConstraint!
	@IBOutlet fileprivate weak var eventsTableView: UITableView!
	@IBOutlet fileprivate weak var friendsTableView: UITableView!

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
	
	/// Adjusts the user interface to match the corresponding selection made
	///
	/// - Parameter sender: The UIButton that was tapped by the user
	@IBAction fileprivate func selectionMade(_ sender: UIButton) {
		let constantValue: CGFloat = (sender === eventsButton) ? 0 : view.bounds.width/2
		
		setValuelessState()
		sender.setTitleColor(.darkGray, for: .normal)
		
		selectionLineCenterX.constant = constantValue
		UIView.animate(withDuration: 0.3, animations: {
			self.view.layoutIfNeeded()
			self.eventsTableView.alpha = (sender === self.eventsButton) ? 1 : 0
			self.friendsTableView.alpha = (sender === self.friendsButton) ? 1 : 0
		})
	}
	
	// MARK: Private
	
	fileprivate func setValuelessState() {
		eventsButton.setTitleColor(.lightGray, for: .normal)
		friendsButton.setTitleColor(.lightGray, for: .normal)
	}
	
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
		let viewModel = WelcomeViewModel(realm: self.viewModel.realm)
		let rootVC = UIViewController()
		rootVC.setInitialViewController(UINavigationController(rootViewController: WelcomeViewController(viewModel: viewModel)))
		self.view.window?.rootViewController = rootVC
		self.view.window?.makeKeyAndVisible()
	}
	
	// MARK: Public

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch tableView {
		case eventsTableView:
			return viewModel.activeAccount.favoriteEvents.count
		case friendsTableView:
			return viewModel.activeAccount.friendsList.count
		default:
			DLog("Error. Could not load tableView")
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch tableView {
		case eventsTableView:
			break
		case friendsTableView:
			break
		default:
			break
		}
		return UITableViewCell()
	}
}
