//
//  CreateEventViewController.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/16/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit
import GooglePlaces
import GooglePlacePicker

// MARK: Class
class CreateEventViewController: UIViewController {
	// MARK: Properties
	@IBOutlet fileprivate weak var eventNameTextField: UITextField!
	@IBOutlet fileprivate weak var dateTextField: UITextField!
	@IBOutlet fileprivate weak var locationTextField: UITextField!
	
	fileprivate let identifier = "CreateEventViewController"
	var viewModel: CreateEventViewModel! = nil
	
	let locationManager = CLLocationManager()
	
	// MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.hideKeyboardWhenScreenTapped()
		
		locationManager.requestWhenInUseAuthorization()
		
		eventNameTextField.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0).isActive = true
		eventNameTextField.indentAndUnderline()
		
		let pickerView = UIDatePicker()
		pickerView.minimumDate = Date()
		pickerView.datePickerMode = .dateAndTime
		pickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
		dateTextField.inputView = pickerView
		dateTextField.indentAndUnderline()
		
		locationTextField.indentAndUnderline()
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonHit(sender:)))
		navigationItem.rightBarButtonItem?.isEnabled = false
		
		viewModel.canFinish.bind { [weak self] canFinish in
			self?.navigationItem.rightBarButtonItem?.isEnabled = canFinish
		}
	}
	
	init (viewModel: CreateEventViewModel) {
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
	@IBAction func textFieldChanged(_ sender: UITextField) {
		if (sender === eventNameTextField) {
			viewModel.updateEventName(eventName: sender.text!)
			
		}
		viewModel.checkRequirements()
	}
	
	// MARK: Private
	@objc fileprivate func dateChanged(_ sender: UIDatePicker) {
		viewModel.updateDate(date: sender.date as NSDate)
		viewModel.checkRequirements()
		dateTextField.text = DateFormatter.localizedString(from: viewModel.date! as Date, dateStyle: .full, timeStyle: .short)
	}
	
	
	
	@objc fileprivate func doneButtonHit(sender: UIButton) {
		// Create an event, add it to the realm, pop this VC and return to feedVC
		let newEvent = Event(eventName: viewModel.eventName, date: viewModel.date!, locationName: (viewModel.location?.name)!, locationLongitude: (viewModel.location?.coordinate.longitude)!, locationLatitude: (viewModel.location?.coordinate.latitude)!)
		// write to realm and save the event
		do {
			try viewModel.realm.write {
				viewModel.realm.add(newEvent)
			}

		} catch {
			DLog("Error. Could not write to the realm, bro")
		}
		self.navigationController?.popViewController(animated: true)
	}
	
	// MARK: Public
	
}

extension CreateEventViewController: GMSPlacePickerViewControllerDelegate, UITextFieldDelegate {
	func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
		// Dismiss the place picker, as it cannot dismiss itself.
		viewController.dismiss(animated: true, completion: nil)
		viewModel.location = place // do a set location here
		viewModel.checkRequirements()
		locationTextField.text = viewModel.location?.name
	}
	
	func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
		// Dismiss the place picker, as it cannot dismiss itself.
		viewController.dismiss(animated: true, completion: nil)
		print("No place selected")
	}

	func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
		if textField === locationTextField {
			let config = GMSPlacePickerConfig(viewport: nil)
			let placePicker = GMSPlacePickerViewController(config: config)
			placePicker.delegate = self
			present(placePicker, animated: true, completion: nil)
		}
		
		return false
	}
}
