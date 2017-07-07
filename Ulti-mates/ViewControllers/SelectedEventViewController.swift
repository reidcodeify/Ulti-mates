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
	
	var viewModel: SelectedEventViewModel? = nil
	
	// MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		mapView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0)
		
		mapView.camera = GMSCameraPosition.camera(withLatitude: (viewModel?.event.locationLatitude)!, longitude: (viewModel?.event.locationLongitude)!, zoom: 12)
		mapView.isMyLocationEnabled = true
		
		let marker = GMSMarker()
		marker.position = CLLocationCoordinate2D(latitude: (viewModel?.event.locationLatitude)!, longitude: (viewModel?.event.locationLongitude)!)
		marker.title = viewModel?.event.locationName
		marker.map = mapView
    }
	
	init(viewModel: SelectedEventViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	// MARK: Control Handlers
	
	// MARK: Private
	
	// MARK: Public

}
