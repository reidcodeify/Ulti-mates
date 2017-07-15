//
//  FeedViewController.swift
//  Ultimate App
//
//  Created by Travis Ouellette on 5/21/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps


// MARK: Class
class FeedViewController: UIViewController {
	// MARK: Properties
	fileprivate var identifier: String = "FeedViewController"
	
	@IBOutlet fileprivate weak var tableView: UITableView!
	@IBOutlet fileprivate weak var mapView: GMSMapView!
	let locationManager = CLLocationManager()
	
	fileprivate var viewModel: FeedViewModel
	
	// MARK: Life Cycle
	init (viewModel: FeedViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	deinit { print(identifier + " dismissed") }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// Set up navigationItem
		let segmentedControl = UISegmentedControl(items: ["List", "Map"])
		segmentedControl.selectedSegmentIndex = 0
		segmentedControl.tintColor = .darkGray
		segmentedControl.addTarget(self, action: #selector(segmentedControlChanged(_:)), for: .valueChanged)
		self.navigationItem.titleView = segmentedControl
		
		let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEventButtonHit(_:)))
		navigationItem.rightBarButtonItem = addButton
		
		let sortButton = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortButtonHit(_:)))
		navigationItem.leftBarButtonItem = sortButton
		
		// Set up tableView
		tableView.register(UINib(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
		tableView.tableFooterView = UIView(frame: .zero)
		tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0).isActive = true
		tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0).isActive = true
		tableView.rowHeight = self.tableView.bounds.height/3
		
		// Set up mapView
		mapView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0).isActive = true
		mapView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor, constant: 0).isActive = true
		mapView.delegate = self
		mapView.camera = GMSCameraPosition.camera(withLatitude: (locationManager.location?.coordinate.latitude)!, longitude: (locationManager.location?.coordinate.longitude)!, zoom: 12)
		mapView.isMyLocationEnabled = true
		mapView.settings.myLocationButton = true
		mapView.settings.compassButton = true
		
		// Set up location services
		locationManager.requestWhenInUseAuthorization()
		locationManager.delegate = self
		
		// Updatable Properties
		viewModel.events.bind { [weak self] _ in
			self?.tableView.reloadData()
		}
		
		viewModel.feedState.bind { [weak self] feedState in
			// animate to the uiview corresponding to the feedState
			if (feedState == .list) {
				UIView.animate(withDuration: 0.3, animations: { 
					self?.mapView.alpha = 0
					self?.tableView.alpha = 1
				})
			} else if (feedState == .map) {
				self?.layoutMarkers()
				UIView.animate(withDuration: 0.3, animations: { 
					self?.tableView.alpha = 0
					self?.mapView.alpha = 1
				})
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Set up mapView
		mapView.isMyLocationEnabled = true
		mapView.delegate = self
		
		
		locationManager.startUpdatingLocation()
		
		layoutMarkers()
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
			DLog("Segmented control index out of range")
		}
	}
	
	@objc fileprivate func sortButtonHit(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "Closest location", style: .default, handler: { action in
			
		}))
		alert.addAction(UIAlertAction(title: "Player count", style: .default) { action in
			
		})
		alert.addAction(UIAlertAction(title: "Soonest start time", style: .default) { action in
			
		})
		alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	@objc fileprivate func addEventButtonHit(_ sender: UIBarButtonItem) {
		// push view controller to specify details about event and create
		let viewModel = CreateEventViewModel(realm: self.viewModel.realm)
		self.navigationController?.pushViewController(CreateEventViewController(viewModel: viewModel), animated: true)
	}
	
	@objc fileprivate func reloadTableViewCell(_ sender: UIButton) {
		tableView.reloadData()
	}
	
	fileprivate func layoutMarkers() {
		for event in viewModel.realm.objects(Event.self) {
			let marker = GMSMarker()
			marker.position = CLLocationCoordinate2D(latitude: (event.location?.latitude)!, longitude: (event.location?.longtitude)!)
			marker.title = event.location?.name
			marker.map = mapView
		}
	}
	
	// MARK: Public

}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource, GMSMapViewDelegate, CLLocationManagerDelegate {
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell: FeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FeedCell") as! FeedTableViewCell
		cell.attendanceButton.addTarget(self, action: #selector(reloadTableViewCell(_:)), for: .touchUpInside)
		return cell
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.events.value.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// push in VC for event details
		let viewModel = self.viewModel.createSelectedViewModel(indexPath.row)
		navigationController?.pushViewController(SelectedEventViewController(viewModel: viewModel), animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let cellViewModel = viewModel.events.value[indexPath.row]
		let typeCastedCell = cell as! FeedTableViewCell
		typeCastedCell.viewModel = cellViewModel
		
		// check to see if this activeAccount is already in the players for each event, if so, then enable the attending button
		if (typeCastedCell.viewModel?.event.players.contains(self.viewModel.activeAccount))! {
			typeCastedCell.attendanceButton.setImage(#imageLiteral(resourceName: "Frisbee Closed"), for: .normal)
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
	
	func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
		// find the event connected to this marker, show a selectedViewController of it
		for selectedViewModel in viewModel.events.value {
			if (selectedViewModel.event.location?.latitude == marker.position.latitude &&
				selectedViewModel.event.location?.longtitude == marker.position.longitude) {
				let viewModel = SelectedEventViewModel(event: selectedViewModel.event, activeAccount: self.viewModel.activeAccount)
				self.navigationController?.pushViewController(SelectedEventViewController(viewModel: viewModel), animated: true)
			}
		}
		return true
	}
}
