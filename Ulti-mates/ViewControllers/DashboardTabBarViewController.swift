//
//  DashboardTabBarViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class
class DashboardTabBarViewController: UITabBarController {
	// MARK: Properties
	fileprivate var identifier: String = "DashboardTabBarViewController"
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .default
	}
	
	fileprivate var viewModel: DashboardViewModel
	
	// MARK: Life Cycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Custom initializer that takes a viewModel
	///
	/// - Parameter viewModel: An instance of DashboardViewModel
	init (viewModel: DashboardViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	deinit { print(identifier + " dismissed") }
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		// Set up UIApplication
		UIApplication.shared.statusBarStyle = .default
		
		// Set up tab bar controller
		self.tabBar.tintColor = ultimatesRed
		
		// Set up navigation controllers
		self.viewControllers = viewModel.setUpViewControllers()
		self.setViewControllers(viewControllers, animated: true)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
//	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//		title = item.title
//	}
	
	// MARK: Private
	
	// MARK: Public
}
