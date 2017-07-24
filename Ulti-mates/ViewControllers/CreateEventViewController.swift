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
	fileprivate let identifier = "CreateEventViewController"

	@IBOutlet fileprivate weak var eventNameTextField: UITextField!
	@IBOutlet fileprivate weak var dateTextField: UITextField!
	@IBOutlet fileprivate weak var locationTextField: UITextField!
	@IBOutlet fileprivate weak var descriptionTextView: UITextView!
	
	var viewModel: CreateEventViewModel! = nil
	
	let locationManager = CLLocationManager()
	
	// MARK: Life Cycle
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Custom initializer that takes a viewModel
	///
	/// - Parameter viewModel: An instance of CreateEventViewModel
	init (viewModel: CreateEventViewModel) {
		self.viewModel = viewModel
		super.init(nibName: identifier, bundle: nil)
	}
	
	deinit { print(identifier + " dismissed") }
	
    override func viewDidLoad() {
        super.viewDidLoad()

		// Set up UIViewController
		self.hideKeyboardWhenScreenTapped()
		
		// Set up UINavigationItem
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonHit(sender:)))
		navigationItem.rightBarButtonItem?.isEnabled = false
		
		// Set up UITextFields
		eventNameTextField.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 0).isActive = true
		eventNameTextField.indentUnderlineAndTint(placeholder: "Event name")
		
		let pickerView = UIDatePicker()
		pickerView.minimumDate = Date()
		pickerView.datePickerMode = .dateAndTime
		pickerView.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
		dateTextField.inputView = pickerView
		dateTextField.indentUnderlineAndTint(placeholder: "Date")

		locationTextField.indentUnderlineAndTint(placeholder: "Location")
		
		// Set up UITextView
		descriptionTextView.placeholder = "Enter a description"
		
		// Updatable Properties
		viewModel.canFinish.bind { [weak self] canFinish in
			self?.navigationItem.rightBarButtonItem?.isEnabled = canFinish
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: Control Handlers
	
	/// Checks the viewModel's requirements, and reflects this assertion with the doneButton's enabled state
	/// If the most recently edited UITextField is eventNameTextField, then update the respective property in the viewModel.
	@IBAction func textFieldChanged(_ sender: UITextField) {
		if (sender === eventNameTextField) {
			viewModel.updateEventName(eventName: sender.text!)
			
		}
		viewModel.checkRequirements()
	}
	
	// MARK: Private
	
	/// Updates the date property in viewModel, and sets the textField's text property to that value
	@objc fileprivate func dateChanged(_ sender: UIDatePicker) {
		viewModel.updateDate(date: sender.date as NSDate)
		viewModel.checkRequirements()
		dateTextField.text = DateFormatter.localizedString(from: viewModel.date! as Date, dateStyle: .full, timeStyle: .short)
	}
	
	/// Creates an event with the completed local variables, and attemps to write to the realm.
	@objc fileprivate func doneButtonHit(sender: UIButton) {
		let newEvent = Event(eventName: viewModel.eventName, date: viewModel.date!, location: viewModel.location!, eventDescription: viewModel.eventDescription)
		
		do {
			try viewModel.realm.write {
				viewModel.realm.add(newEvent)
			}

		} catch {
			DLog("Error. Could not write to the realm")
		}
		self.navigationController?.popViewController(animated: true)
	}
	
	// MARK: Public
	
}

extension CreateEventViewController: GMSPlacePickerViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
	func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
		viewController.dismiss(animated: true, completion: nil)
		viewModel.location = place
		viewModel.checkRequirements()
		locationTextField.text = viewModel.location?.name
	}
	
	func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
		viewController.dismiss(animated: true, completion: nil)
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
	
	/// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
	///
	/// - Parameter textView: The UITextView that got updated
	func textViewDidChange(_ textView: UITextView) {
		textView.assertPlaceHolderLabel()
	}
	
	func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
		if (textView.text.characters.count + text.characters.count < 100) {
			viewModel.updateEventDescription(eventDescription: textView.text)
			return true
		}
		
		return false
	}
}
