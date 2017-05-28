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
	private var identifier: String = "DashboardTabBarViewController"
	private var viewModel: DashboardViewModel
	
	// MARK: Life Cycle
	init (viewModel: DashboardViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		let profileViewModel: ProfileViewModel = ProfileViewModel(account: viewModel.activeAccount)
		
		let feedViewController = FeedViewController()
		let messagesViewController = MessagesViewController()
		let profileViewController = ProfileViewController(viewModel: profileViewModel)
		
		feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(named: "Feed"), tag: 0)
		messagesViewController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "Message"), tag: 1)
		profileViewController.tabBarItem = UITabBarItem(title: "\(viewModel.activeAccount.name)", image: UIImage(named: "Profile"), tag: 2)
		
		self.viewControllers = [feedViewController, messagesViewController, profileViewController]
		self.setViewControllers(viewControllers, animated: true)
		
		self.title = feedViewController.tabBarItem.title
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
		title = item.title
	}
	
	// MARK: Private
	
	// MARK: Public
}
