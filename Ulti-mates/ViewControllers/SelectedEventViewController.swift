//
//  SelectedEventViewController.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/22/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit
import GoogleMaps

// MARK: Class
class SelectedEventViewController: UIViewController {
	// MARK: Properties
	fileprivate let identifier: String = "SelectedEventViewController"
	
	@IBOutlet fileprivate weak var mapView: GMSMapView!
	@IBOutlet fileprivate weak var chatButton: UIButton!
	@IBOutlet fileprivate weak var aboutButton: UIButton!
	@IBOutlet fileprivate weak var playersButton: UIButton!
	@IBOutlet fileprivate weak var selectionLineCenter: NSLayoutConstraint!
	@IBOutlet fileprivate weak var aboutView: UIView!
	@IBOutlet fileprivate weak var aboutTextView: UITextView!
	@IBOutlet fileprivate weak var timeAndDateLabel: UILabel!
	@IBOutlet fileprivate weak var segmentedControl: UISegmentedControl!
	@IBOutlet fileprivate weak var playersTableView: UITableView!
	
	fileprivate var constraintToRevealMap = NSLayoutConstraint()
	fileprivate var constraintToHideMap = NSLayoutConstraint()
	
	fileprivate let directionsBarButton = UIBarButtonItem(title: "Directions", style: .plain, target: self, action: #selector(directionsButtonHit(_:)))
	
	let viewModel: SelectedEventViewModel
	
	// MARK: Life Cycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Custom initializer that takes a viewModel
	///
	/// - Parameter viewModel: An instance of SelectedEventViewModel
	init(viewModel: SelectedEventViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	deinit { print(identifier + " dismissed") }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Set up UINavigationItem
		self.title = viewModel.event.eventName
		navigationItem.rightBarButtonItem = directionsBarButton

        // Set up mapView
		mapView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0).isActive = true
		mapView.camera = GMSCameraPosition.camera(withLatitude: (viewModel.event.location?.latitude)!, longitude: (viewModel.event.location?.longtitude)!, zoom: 16)
		mapView.isMyLocationEnabled = true
		mapView.settings.myLocationButton = true
		mapView.settings.compassButton = true
		
		let marker = GMSMarker()
		marker.position = CLLocationCoordinate2D(latitude: (viewModel.event.location?.latitude)!, longitude: (viewModel.event.location?.longtitude)!)
		marker.title = viewModel.event.location?.name
		marker.map = mapView
		constraintToRevealMap = NSLayoutConstraint(item: mapView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.33, constant: 0)
		constraintToHideMap = NSLayoutConstraint(item: mapView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.0, constant: 0)
		constraintToRevealMap.isActive = true
		constraintToHideMap.isActive = false
		
		// Set starting x-position on the selectionLine center constraint
		selectionLineCenter.constant = 0
		
		// Set up aboutView
		aboutView.alpha = 1
		timeAndDateLabel.text = DateFormatter.localizedString(from: viewModel.event.date as Date, dateStyle: .full, timeStyle: .short)
		aboutTextView.text = viewModel.event.eventDescription
		
		// Set up playersTableView
		playersTableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayersCell")
		playersTableView.tableFooterView = UIView(frame: .zero)
		playersTableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0).isActive = true
		playersTableView.alpha = 0
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		// if the player is attending already, then select segment 0. if they are maybe, then select 1. otherwise, set to no selection
		if (viewModel.event.activePlayers.contains(viewModel.activeAccount)) {
			segmentedControl.selectedSegmentIndex = 0
		} else if (viewModel.event.maybePlayers.contains(viewModel.activeAccount)) {
			segmentedControl.selectedSegmentIndex = 1
		} else {
			segmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
		}
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
		var constantValue: CGFloat = 0
		
		setValuelessState()
		sender.setTitleColor(.darkGray, for: .normal)
		navigationItem.rightBarButtonItem = (sender === aboutButton) ? directionsBarButton : nil
		constraintToHideMap.isActive = (sender === aboutButton) ? false : true
		constraintToRevealMap.isActive = (sender === playersButton || sender === chatButton) ? false : true
		
		if (sender === aboutButton) {
			constantValue = 0
		} else if (sender === playersButton) {
			constantValue = view.bounds.width/3
			playersTableView.reloadData()
		} else if (sender === chatButton) {
			constantValue = view.bounds.width - view.bounds.width/3
		}
		
		selectionLineCenter.constant = constantValue
		UIView.animate(withDuration: 0.3, animations: {
			self.view.layoutIfNeeded()
			self.aboutView.alpha = (sender === self.aboutButton) ? 1 : 0
			self.playersTableView.alpha = (sender === self.playersButton) ? 1 : 0
		})
	}
	
	/// Adjusts the players position in the event's player lists
	@IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0: viewModel.playerIsAttending()
		case 1: viewModel.playerIsPossiblyAttending()
		default: DLog("Error. Could not determine which button in UISegmentedControl was hit") }
	}
	
	// MARK: Private
	fileprivate func setValuelessState() {
		aboutButton.setTitleColor(.lightGray, for: .normal)
		playersButton.setTitleColor(.lightGray, for: .normal)
		chatButton.setTitleColor(.lightGray, for: .normal)
		aboutView.alpha = 0
		playersTableView.alpha = 0
	}
	
	@objc fileprivate func directionsButtonHit(_ sender: UIBarButtonItem) {
		print("hit")
	}
	
	// MARK: Public

}

// MARK: Extension
extension SelectedEventViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch section {
		case 0:
			return viewModel.event.activePlayers.count
		case 1:
			return viewModel.event.maybePlayers.count
		default:
			DLog("Error. Could not load rows into sections")
			return -1
		}
	}
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch section {
		case 0:
			return "Going"
		case 1:
			return "Maybe"
		default:
			DLog("Could not load header titles")
			return nil
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: PlayersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlayersCell") as! PlayersTableViewCell
		
		switch indexPath.section {
		case 0: cell.textLabel?.text = viewModel.event.activePlayers[indexPath.row].name
		case 1: cell.textLabel?.text = viewModel.event.maybePlayers[indexPath.row].name
		default: DLog("Error. Could not load rows into tableview") }
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// present playercard of that player
		//let account = self.viewModel.event.realm?.object(ofType: <#T##T.Type#>, forPrimaryKey: <#T##K#>)
		//let viewModel: PlayerCardViewModel = PlayerCardViewModel(activeAccount: self.viewModel.event.realm?.objects(ActiveAccount).index(of: <#T##ActiveAccount#>))
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
