//
//  FeedTableViewCell.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/13/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import UIKit

// MARK: Class
class FeedTableViewCell: UITableViewCell {
	// MARK: Properties
	@IBOutlet fileprivate weak var eventNameLabel: UILabel!
	@IBOutlet fileprivate weak var locationLabel: UILabel!
	@IBOutlet fileprivate weak var dateLabel: UILabel!
	@IBOutlet fileprivate weak var playerAttendanceLabel: UILabel!
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
			unattendButton.setTitleColor(UIColor.lightGray, for: .normal)
		} else {
			viewModel?.updatePlayerCount(shouldAdd: false)
			attendButton.setTitleColor(UIColor.lightGray, for: .normal)
		}
		
		sender.setTitleColor(self.tintColor, for: .normal)
		self.setNeedsLayout()
		self.layoutIfNeeded()
	}
	
	// MARK: Private
	fileprivate func attach(viewModel: FeedTableViewCellViewModel) {
		dateLabel.text = DateFormatter.localizedString(from: viewModel.event.date as Date, dateStyle: .full, timeStyle: .short)
		locationLabel.text = viewModel.event.locationName
		eventNameLabel.text = viewModel.event.eventName
		playerAttendanceLabel.text = "\(viewModel.event.players.count) player(s)"
	}
	
	fileprivate func checkRealmEvents(for: Event) -> Event? {
		for event in (viewModel?.realm.objects(Event.self))! {
			if (event === self.viewModel?.event) {
				return event
			}
		}
		
		return nil
	}
	
	// MARK: Public
    
}
