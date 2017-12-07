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
	
	/// Updates the favorite list for the currently active account
	func updateFavorites(shouldAdd: Bool, event: Event) {
		if (shouldAdd && !activeAccount.favoriteEvents.contains(event)) {
			try! event.realm?.write {
				activeAccount.favoriteEvents.append(event)
			}
		} else if (!shouldAdd && activeAccount.favoriteEvents.contains(event)) {
			try! event.realm?.write {
				activeAccount.favoriteEvents.remove(objectAtIndex: activeAccount.favoriteEvents.index(of: event)!)
			}
		}
	}
	
	/// Sets the backgroundImage of the cell with the passed image
	///
	/// - Parameter image: An instance of UIImage
	func updateBackgroundImage(image: UIImage) {
		self.backgroundImage = image
	}
}
