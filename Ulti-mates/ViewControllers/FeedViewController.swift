//
//  FeedViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit


// MARK: Class
class FeedViewController: UIViewController {
	// MARK: Properties
	fileprivate var identifier: String = "FeedViewController"
	
	@IBOutlet fileprivate weak var tableView: UITableView!
	
	fileprivate var viewModel: FeedViewModel! = nil
	
	// MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.rowHeight = self.view.bounds.height/6
		tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
		tableView.tableFooterView = UIView(frame: .zero)
		
		// Set up NavigationBar
		let segmentedControl = UISegmentedControl(items: ["List", "Map"])
		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
		self.navigationItem.titleView = segmentedControl
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonHit(_:)))
		navigationItem.rightBarButtonItem = addButton
		
		// Updatable Properties
		viewModel.feedState.bind { [weak self] feedState in
			// animate to the uiview corresponding to the feedState
		}
	}
	
	init (viewModel: FeedViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		// populate table view data from realm storage
		viewModel.events = []
		for event in viewModel.realm.objects(Event.self) {
			viewModel.events.append(event)
		}
		tableView.reloadData()
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
	
	@objc fileprivate func addButtonHit(_ sender: UIBarButtonItem) {
		// push view controller to specify details about event and create
		let viewModel = CreateEventViewModel(realm: self.viewModel.realm)
		self.navigationController?.pushViewController(CreateEventViewController(viewModel: viewModel), animated: true)
	}
	
	// MARK: Public

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedTableViewCell
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.events.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// push in VC for event details
		let viewModel = SelectedEventViewModel(event: self.viewModel.events[indexPath.row], activeAccount: self.viewModel.activeAccount)
		navigationController?.pushViewController(SelectedEventViewController(viewModel: viewModel), animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let event = viewModel.events[indexPath.row]
		let cellViewModel = FeedTableViewCellViewModel(realm: viewModel.realm, event: event)
		let typeCastedCell = cell as! FeedTableViewCell
		typeCastedCell.viewModel = cellViewModel
	}
	
	// To swipe delete cells
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if (editingStyle == UITableViewCellEditingStyle.delete) {
			let cell = tableView.cellForRow(at: indexPath) as! FeedTableViewCell
			viewModel.events.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
			
			try! viewModel.realm.write {
				viewModel.realm.delete((cell.viewModel?.event)!)
			}
			
			tableView.reloadData()
		}
	}
}
