//
//  WelcomeViewController2.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 7/24/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

// MARK: Class
class WelcomeViewController2: UIViewController {
	// MARK: Properties
	fileprivate let identifier: String = "WelcomeViewController2"
	
	@IBOutlet fileprivate weak var logoImageView: UIImageView!
	@IBOutlet fileprivate weak var facebookButton: UIButton!
	@IBOutlet fileprivate weak var createAccountButton: UIButton!
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	fileprivate var viewModel: WelcomeViewModel2
	
	// MARK: Life Cycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Custom initializer that takes a viewModel
	///
	/// - Parameter viewModel: An instance of WelcomeViewModel
	init(viewModel: WelcomeViewModel2) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	deinit { print(identifier + " dismissed") }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		if (FBSDKAccessToken.current()) != nil {
			
		}
		
		// Set up Self
		UIApplication.shared.statusBarStyle = .lightContent
		
		// Set up UINavigationController
		if let navigationController = navigationController {
			navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in", style: .plain, target: self, action: #selector(logInButtonHit(_:)))
			navigationController.navigationBar.tintColor = .white
			navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
			navigationController.navigationBar.shadowImage = UIImage()
			navigationController.navigationBar.isTranslucent = true
			navigationController.view.backgroundColor = .clear
		} else {
			DLog("Error: Absence of UINavigation controller")
		}
		
		// Set up UIButtons
		facebookButton.layer.cornerRadius = facebookButton.frame.height/2
		facebookButton.addTarget(self, action: #selector(facebookButtonHit(_:)), for: .touchUpInside)
		createAccountButton.layer.cornerRadius = createAccountButton.frame.height/2
		createAccountButton.layer.borderWidth = 1
		createAccountButton.layer.borderColor = UIColor.white.cgColor
		
		// Set up UIImage
		logoImageView.image = (logoImageView.image?.withRenderingMode(.alwaysTemplate))!
		logoImageView.tintColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	
	/// Pushes CreateAccountViewController in
	@IBAction func createAccountButtonHit(_ sender: UIButton) {
		if let navigationController = navigationController {
			let viewModel = CreateAccountViewModel(realm: self.viewModel.realm)
			navigationController.pushViewController(CreateAccountViewController(viewModel: viewModel), animated: true)
		} else {
			DLog("Error: Absence of UINavigation controller")
		}
	}
	
	// MARK: Private
	
	/// Pushes LogInViewController in
	@objc fileprivate func logInButtonHit(_ sender: UIBarButtonItem) {
		if let navigationController = navigationController {
			let viewModel = LogInViewModel(realm: self.viewModel.realm)
			navigationController.pushViewController(LogInViewController(viewModel: viewModel), animated: true)
		} else {
			DLog("Error: Absence of UINavigation controller")
		}
	}
	
	/// Handles sign in from facebook
	@objc fileprivate func facebookButtonHit(_ sender: UIButton) {
		let loginManager = LoginManager()
		loginManager.logIn([ .publicProfile, .email, .userFriends ], viewController: self) { loginResult in
			switch loginResult {
			case .failed(let error):
				print(error)
			case .cancelled:
				print("User cancelled login.")
			case .success( _, _, _):
				let graphRequest:FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"name, email"])
				graphRequest.start(completionHandler: { (connection, result, error) -> Void in
					if ((error) != nil) {
						print("Error: \(String(describing: error))")
					} else {
						let data:[String:AnyObject] = result as! [String : AnyObject]
						let name = data["name"]! as! String
						let email = data["email"]! as! String
						var accountToTransitionWith: ActiveAccount
						
						if (self.viewModel.accountDoesNotExist(emailToCheck: email, nameToCheck: name)) {
							// create account in realm
							accountToTransitionWith = ActiveAccount(name: name, email: email, password: nil)
							try! self.viewModel.realm.write {
								self.viewModel.realm.add(accountToTransitionWith)
							}
						} else {
							// fetch account
							if let tempAccount = self.viewModel.fetchExistingAccount(withEmail: email, withName: name) {
								accountToTransitionWith = tempAccount
							}
							accountToTransitionWith = self.viewModel.fetchExistingAccount(withEmail: email, withName: name)!
						}
						
						let viewModel = DashboardViewModel(realm: self.viewModel.realm, account: accountToTransitionWith)
						let rootVC = UIViewController()
						rootVC.setInitialViewController(DashboardTabBarViewController(viewModel: viewModel))
						self.view.window?.rootViewController = rootVC
						self.view.window?.makeKeyAndVisible()
					}
				})
			
			}
		}
	}

	// MARK: Public

}
	
