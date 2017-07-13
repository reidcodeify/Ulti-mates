//
//  FeedViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit
import GooglePlaces


// MARK: Class
class FeedViewController: UIViewController {
	// MARK: Properties
	fileprivate var identifier: String = "FeedViewController"
	
	@IBOutlet fileprivate weak var tableView: UITableView!
	
	fileprivate var viewModel: FeedViewModel
	
	// MARK: Life Cycle
	init (viewModel: FeedViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.rowHeight = self.view.bounds.height/4
		tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
		tableView.tableFooterView = UIView(frame: .zero)
		
		// Set up NavigationBar
		
		let segmentedControl = UISegmentedControl(items: ["List", "Map"])
		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.tintColor = .darkGray
		segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
		self.navigationItem.titleView = segmentedControl
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEventButtonHit(_:)))
		navigationItem.rightBarButtonItem = addButton
		
		// Updatable Properties
		viewModel.events.bind { [weak self] _ in
			self?.tableView.reloadData()
		}
		
		viewModel.feedState.bind { [weak self] feedState in
			// animate to the uiview corresponding to the feedState
			if (feedState == .list) {
				
			} else {
				
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

	// MARK: Private
	@objc fileprivate func segmentedControlChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			self.viewModel.updateFeedState(to: .list)
		case 1:
			self.viewModel.updateFeedState(to: .map)
		default:
			DLog("Segmented control index out of range, bro")
		}
	}
	
	@objc fileprivate func addEventButtonHit(_ sender: UIBarButtonItem) {
		// push view controller to specify details about event and create
		let viewModel = CreateEventViewModel(realm: self.viewModel.realm)
		self.navigationController?.pushViewController(CreateEventViewController(viewModel: viewModel), animated: true)
	}
	
	@objc fileprivate func reloadTableViewCell(_ sender: UIButton) {
		tableView.reloadData()
	}
	
	// MARK: Public

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedTableViewCell
		cell.attendButton.addTarget(self, action: #selector(reloadTableViewCell(_:)), for: .touchUpInside)
		cell.unattendButton.addTarget(self, action: #selector(reloadTableViewCell(_:)), for: .touchUpInside)
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.events.value.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// push in VC for event details
//		let viewModel = SelectedEventViewModel(event: self.viewModel.events[indexPath.row], activeAccount: self.viewModel.activeAccount) // make viewModel func to handle this (return a viewModel)
//		navigationController?.pushViewController(SelectedEventViewController(viewModel: viewModel), animated: true)
//		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let cellViewModel = viewModel.events.value[indexPath.row]
		let typeCastedCell = cell as! FeedTableViewCell
		typeCastedCell.viewModel = cellViewModel
		
		// check to see if this activeAccount is already in the players for each event, if so, then enable the attending button
		if (typeCastedCell.viewModel?.event.players.contains(self.viewModel.activeAccount))! {
			typeCastedCell.attendButton.setTitle("Attending", for: .normal)
			typeCastedCell.attendButton.setTitleColor(ultimatesRed, for: .normal)
		}
	}
	
	// To swipe delete cells
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if (editingStyle == UITableViewCellEditingStyle.delete) {
			let cell = tableView.cellForRow(at: indexPath) as! FeedTableViewCell
			
			try! viewModel.realm.write {
				viewModel.realm.delete((cell.viewModel?.event)!)
			}
		}
	}
}
