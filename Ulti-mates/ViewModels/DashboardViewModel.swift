//
//  DashboardViewModel.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: Class
class DashboardViewModel {
	// MARK: Properties
	var realm: Realm
	var activeAccount: ActiveAccount
	
	// MARK: Life Cycle
	
	/// Initializer that takes a realm and an activeAccount
	///
	/// - Parameter realm: An instance of Realm
	/// - Parameter activeAccount: An instance of ActiveAccount
	init (realm: Realm, account: ActiveAccount) {
		self.realm = realm
		activeAccount = account
	}
	
	// MARK: Private
	
	// MARK: Public
	
	/// Returns an array of viewControllers to be used by DashboardTabBarController when setting its viewControllers property
	func setUpViewControllers() -> [UIViewController] {
		let feedViewModel = FeedViewModel(realm: realm, activeAccount: activeAccount)
		let messagesViewModel = MessagesViewModel(realm: realm, activeAccount: activeAccount)
		let profileViewModel = ProfileViewModel(realm: realm, activeAccount: activeAccount)
		
		let feedViewController = UINavigationController(rootViewController: FeedViewController(viewModel: feedViewModel))
		let messagesViewController = UINavigationController(rootViewController: MessagesViewController(viewModel: messagesViewModel))
		let profileViewController = UINavigationController(rootViewController: ProfileViewController(viewModel: profileViewModel))
		
		feedViewController.navigationBar.tintColor = .darkGray
		messagesViewController.navigationBar.tintColor = .darkGray
		profileViewController.navigationBar.tintColor = .darkGray
		
		feedViewController.tabBarItem = UITabBarItem(title: "Events", image: UIImage(named: "Feed"), tag: 0)
		messagesViewController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "Message"), tag: 1)
		profileViewController.tabBarItem = UITabBarItem(title: "\(activeAccount.name)", image: UIImage(named: "Profile"), tag: 2)
		
		return [feedViewController, messagesViewController, profileViewController]
	}
}
