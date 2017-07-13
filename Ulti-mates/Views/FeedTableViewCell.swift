//
//  FeedTableViewCell.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/13/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit
import GooglePlaces

// MARK: Class
class FeedTableViewCell: UITableViewCell {
	// MARK: Properties
	@IBOutlet fileprivate weak var eventNameLabel: UILabel!
	@IBOutlet fileprivate weak var dateLabel: UILabel!
	@IBOutlet fileprivate weak var playerAttendanceLabel: UILabel!
	@IBOutlet weak var backgroundImage: UIImageView!
	@IBOutlet weak var attendButton: UIButton!
	@IBOutlet weak var unattendButton: UIButton!
	
	var viewModel: FeedTableViewCellViewModel? {
		didSet {
			if let newViewModel = viewModel {
				attach(viewModel: newViewModel)
			}
		}
	}
	
	// MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	// MARK: Control Handlers
	@IBAction func attendenceButtonHit(_ sender: UIButton) {
		// for both: set active color, set attending property on viewModel
		if (sender === attendButton) {
			viewModel?.updatePlayerCount(shouldAdd: true)
			attendButton.setTitle("Attending", for: .normal)
			unattendButton.setTitleColor(UIColor.lightGray, for: .normal)
		} else {
			viewModel?.updatePlayerCount(shouldAdd: false)
			attendButton.setTitle("Attend", for: .normal)
			attendButton.setTitleColor(UIColor.lightGray, for: .normal)
		}
		
		sender.setTitleColor(ultimatesRed, for: .normal)
	}
	
	// MARK: Private
	fileprivate func attach(viewModel: FeedTableViewCellViewModel) {
		dateLabel.text = DateFormatter.localizedString(from: viewModel.event.date as Date, dateStyle: .none, timeStyle: .short)
		eventNameLabel.text = viewModel.event.eventName
		playerAttendanceLabel.text = "\(viewModel.event.players.count) player(s)"
		//loadFirstPhotoForPlace(placeID: (viewModel.event.location?.placeID)!)
	}
	
	fileprivate func loadFirstPhotoForPlace(placeID: String) {
		GMSPlacesClient.shared().lookUpPhotos(forPlaceID: placeID) { (photos, error) -> Void in
			if let error = error {
				// TODO: handle the error.
				print("Error: \(error.localizedDescription)")
			} else {
				if let firstPhoto = photos?.results.first {
					self.loadImageForMetadata(photoMetadata: firstPhoto)
				}
			}
		}
	}
	
	fileprivate func loadImageForMetadata(photoMetadata: GMSPlacePhotoMetadata) {
		GMSPlacesClient.shared().loadPlacePhoto(photoMetadata, callback: { (photo, error) -> Void in
			if let error = error {
				// TODO: handle the error.
				print("Error: \(error.localizedDescription)")
			} else {
				self.backgroundImage.image = photo
			}
		})
	}
	
	// MARK: Public
    
}
