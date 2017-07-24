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
	@IBOutlet weak var attendanceButton: UIButton!
	@IBOutlet weak var backgroundImageView: UIImageView!
	
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
		backgroundImageView.image = viewModel?.backgroundImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	// MARK: Control Handlers
	
	/// If the button's state is activated, the viewModel will know to add the activeAccount
	/// If the button's state is not activated, the viewModel will know not to add the activeAccount
	@IBAction func attendenceButtonHit(_ sender: UIButton) {
		// for both: set active color, set attending property on viewModel
		if (attendanceButton.imageView?.image == #imageLiteral(resourceName: "Frisbee Open")) {
			viewModel?.updatePlayerCount(shouldAdd: true)
			attendanceButton.setImage(#imageLiteral(resourceName: "Frisbee Closed"), for: .normal)
		} else {
			viewModel?.updatePlayerCount(shouldAdd: false)
			attendanceButton.setImage(#imageLiteral(resourceName: "Frisbee Open"), for: .normal)
		}
	}
	
	// MARK: Private
	
	/// Updates cell UI with current viewModel data 
	fileprivate func attach(viewModel: FeedTableViewCellViewModel) {
		dateLabel.text = DateFormatter.localizedString(from: viewModel.event.date as Date, dateStyle: .short, timeStyle: .short)
		eventNameLabel.text = viewModel.event.eventName
		playerAttendanceLabel.text = "\(viewModel.event.players.count) player(s)"
	}
	
	// MARK: Public
    
}
