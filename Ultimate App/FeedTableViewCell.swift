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
	@IBOutlet fileprivate weak var dateLabel: UILabel!
	@IBOutlet fileprivate weak var playerAttendanceLabel: UILabel!
	@IBOutlet fileprivate weak var attendButton: UIButton!
	@IBOutlet fileprivate weak var unattendButton: UIButton!
	
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
		
		viewModel?.event.bind { [weak self] canContinue in
			self?.playerAttendanceLabel.text = "\(String(describing: self?.viewModel?.event.value.playerCount)) player(s)"
		}
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	// MARK: Control Handlers
	@IBAction func attendenceButtonHit(_ sender: UIButton) {
		// for both: set active color, set attending property on viewModel
		if (sender === attendButton) {
			viewModel?.setAttending(isAttending: true)
			unattendButton.setTitleColor(UIColor.lightGray, for: .normal)
		} else if (sender === unattendButton) {
			viewModel?.setAttending(isAttending: false)
			attendButton.setTitleColor(UIColor.lightGray, for: .normal)
		}
		
		let attendanceCount: Int = (viewModel?.isAttending)! ? 1 : -1
		viewModel?.updatePlayerCount(amountToAdd: attendanceCount)
		
		sender.setTitleColor(self.tintColor, for: .normal)
	}
	
	// MARK: Private
	fileprivate func attach(viewModel: FeedTableViewCellViewModel) {
		dateLabel.text = DateFormatter.localizedString(from: viewModel.event.value.date as Date, dateStyle: .full, timeStyle: .short)
		eventNameLabel.text = viewModel.event.value.eventName
		playerAttendanceLabel.text = "\(viewModel.event.value.playerCount) players"
	}
	
	fileprivate func checkRealmEvents(for: Event) -> Event? {
		for event in (viewModel?.realm.objects(Event.self))! {
			if (event === self.viewModel?.event.value) {
				return event
			}
		}
		
		return nil
	}
	
	// MARK: Public
    
}
