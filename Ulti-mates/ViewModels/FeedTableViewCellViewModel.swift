//
//  FeedTableViewCellViewModel.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/13/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import RealmSwift
import GooglePlaces

// MARK: Class
class FeedTableViewCellViewModel {
	// MARK: Properties
	var activeAccount: ActiveAccount
	var event: Event
	var backgroundImage: UIImage?
	
	// MARK: Life Cycle
	
	/// Initializer that takes an activeAccount and an event
	///
	/// - Parameter activeAccount: An instance of ActiveAccount
	/// - Parameter event: An instance of Event
	init (activeAccount: ActiveAccount, event: Event) {
		self.activeAccount = activeAccount
		self.event = event
		loadFirstPhotoForPlace(placeID: (event.location?.placeID)!)
	}
	
	// MARK: Private
	
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
				self.backgroundImage = photo
			}
		})
	}
	
	// MARK: Public
	
	/// Takes a Bool, that determines how the event's players property should be manipulated
	/// If true, the realm is written to and the event's players property is appended with activeAccount
	/// If false, the realm is written to, and the event's players property inversely removes the activeAccount
	///
	/// - Parameter shouldAdd: Signals to this function how the event should be manipulated
	func updatePlayerCount(shouldAdd: Bool) {
		if (shouldAdd == true && !event.players.contains(activeAccount)) {
			try! event.realm?.write {
				event.players.append(activeAccount)
			}
		} else if (shouldAdd == false && event.players.contains(activeAccount)) {
			try! event.realm?.write {
				event.players.remove(objectAtIndex: event.players.index(of: activeAccount)!)
			}
		}
	}
	
	/// Sets the backgroundImage of the call with the passed image
	///
	/// - Parameter image: An instance of UIImage
	func updateBackgroundImage(image: UIImage) {
		self.backgroundImage = image
	}
}
