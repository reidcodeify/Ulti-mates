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
	@IBOutlet fileprivate weak var directionsButton: UIButton!
	@IBOutlet fileprivate weak var aboutTextView: UITextView!
	@IBOutlet fileprivate weak var playersTableView: UITableView!
	
	fileprivate var constraintToRevealMap = NSLayoutConstraint()
	fileprivate var constraintToHideMap = NSLayoutConstraint()
	
	fileprivate let playersBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Frisbee Open"), style: .plain, target: self, action: #selector(attendanceButtonHit(_:)))
	
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
		directionsButton.roundAndShadow()
		
		// Set up aboutTextView
		aboutTextView.text = viewModel.event.eventDescription
		
		// Set up playersTableView
		playersTableView.register(UINib(nibName: "PlayersTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayersCell")
		playersTableView.tableFooterView = UIView(frame: .zero)
		playersTableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0).isActive = true
		playersTableView.alpha = 0
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	
	/// Provides the next steps (?) for a user to proceed with getting to the event's location
	@IBAction func directionsButtonHit(_ sender: UIButton) {
		
	}
	
	// MARK: Private
	fileprivate func setValuelessState() {
		aboutButton.setTitleColor(.lightGray, for: .normal)
		playersButton.setTitleColor(.lightGray, for: .normal)
		chatButton.setTitleColor(.lightGray, for: .normal)
		aboutView.alpha = 0
		playersTableView.alpha = 0
	}
	
	/// Adjusts the user interface to match the corresponding selection made
	///
	/// - Parameter sender: The UIButton that was tapped by the user
	@IBAction fileprivate func selectionMade(_ sender: UIButton) {
		var constantValue: CGFloat = 0
		
		setValuelessState()
		sender.setTitleColor(.darkGray, for: .normal)
		
		if (sender === aboutButton) {
			constraintToHideMap.isActive = false
			constraintToRevealMap.isActive = true
			navigationItem.rightBarButtonItem = nil
			constantValue = 0
		} else if (sender === playersButton) {
			constraintToRevealMap.isActive = false
			constraintToHideMap.isActive = true
			navigationItem.rightBarButtonItem = playersBarButton
			constantValue = view.bounds.width/3
		} else if (sender === chatButton) {
			constraintToRevealMap.isActive = false
			constraintToHideMap.isActive = true
			navigationItem.rightBarButtonItem = nil
			constantValue = view.bounds.width - view.bounds.width/3
		}
		
		selectionLineCenter.constant = constantValue
		UIView.animate(withDuration: 0.3, animations: {
			self.view.layoutIfNeeded()
			self.aboutView.alpha = (sender === self.aboutButton) ? 1 : 0
			self.playersTableView.alpha = (sender === self.playersButton) ? 1 : 0
		})
	}
	
	@objc fileprivate func attendanceButtonHit(_ sender: UIBarButtonItem) {
		sender.image = (sender.image == #imageLiteral(resourceName: "Frisbee Open")) ? #imageLiteral(resourceName: "Frisbee Closed") : #imageLiteral(resourceName: "Frisbee Open")
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
