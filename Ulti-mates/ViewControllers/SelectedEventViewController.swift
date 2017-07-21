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
	@IBOutlet fileprivate weak var chatroomButton: UIButton!
	@IBOutlet fileprivate weak var playersButton: UIButton!
	@IBOutlet fileprivate weak var selectionLineCenter: NSLayoutConstraint!
	@IBOutlet fileprivate weak var playersTableView: UITableView!
	
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
	
	deinit { print(identifier + "dismissed") }
	
    override func viewDidLoad() {
        super.viewDidLoad()

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
		
		// Set starting x-position on the selectionLine center constraint
		selectionLineCenter.constant = 0
		
		// Set up playersTableView
		playersTableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayersCell")
		playersTableView.tableFooterView = UIView(frame: .zero)
		playersTableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0).isActive = true
		playersTableView.alpha = 0
		
		// Set up UIButtons
		chatroomButton.setTitleColor(.darkText, for: .normal)
		playersButton.setTitleColor(.lightGray, for: .normal)
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	
	// MARK: Private
	
	/// Adjusts the user interface to match the corresponding selection made
	///
	/// - Parameter sender: The UIButton that was tapped by the user
	@IBAction fileprivate func selectionMade(_ sender: UIButton) {
		if (sender === chatroomButton) {
			playersButton.setTitleColor(.lightGray, for: .normal)
			UIView.animate(withDuration: 0.3, animations: { 
				self.playersTableView.alpha = 0
			})
		} else if (sender === playersButton) {
			chatroomButton.setTitleColor(.lightGray, for: .normal)
			UIView.animate(withDuration: 0.3, animations: { 
				self.playersTableView.alpha = 1
			})
		}
		
		sender.setTitleColor(.darkGray, for: .normal)
		selectionLineCenter.constant = (sender === chatroomButton) ? 0 : view.bounds.midX
		UIView.animate(withDuration: 0.3, animations: {
			self.view.layoutIfNeeded()
		})
	}
	
	// MARK: Public

}

// MARK: Extension
extension SelectedEventViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.event.players.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: PlayersTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PlayersCell") as! PlayersTableViewCell
		cell.textLabel?.text = viewModel.event.players[indexPath.row].name
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
