//
//  FeedViewModel.swift
//  Ulti-mates
//
//  Created by Travis Ouellette on 6/11/17.
//  Copyright © 2017 Codeify. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import GooglePlaces

// MARK: Class
class FeedViewModel {
	// MARK: Properties
	var realm: Realm
	var activeAccount: ActiveAccount
	var events: UpdatableProperty<[FeedTableViewCellViewModel]> = UpdatableProperty(value: [])
	var resultsToken: NotificationToken?
	var isFeedEnabled = UpdatableProperty<Bool>(value: true)
	
	fileprivate var fetchedEvents: Results<Event>? = nil {
		didSet {
			guard let newFetchedEvents = fetchedEvents else {
				events.update([])
				return
			}
			
			let eventViewModels: [FeedTableViewCellViewModel] = newFetchedEvents.map({ event -> FeedTableViewCellViewModel in
				return FeedTableViewCellViewModel(activeAccount: activeAccount, event: event)
			})
			events.update(eventViewModels)
		}
	}
	
	// MARK: Life Cycle
	
	/// Initializer that takes a realm and an activeAccount
	///
	/// - Parameter realm: An instance of Realm
	/// - Parameter activeAccount: An instance of ActiveAccount
	init (realm: Realm, activeAccount: ActiveAccount) {
		self.realm = realm
		self.activeAccount = activeAccount
		fetchEvents()
	}
	
	deinit { resultsToken?.stop() }
	
	// MARK: Private
	fileprivate func fetchEvents() {
		let results = realm.objects(Event.self)
		
		resultsToken = results.addNotificationBlock { [weak self] changes in
			switch changes {
			case .initial(let results):
				self?.fetchedEvents = results
			case .update(let results, _, _, _):
				self?.fetchedEvents = results
			case .error(let error):
				DLog("Event fetch error: \(error.localizedDescription)")
			}
		}
	}
	
	// MARK: Public
	
	/// Takes a Bool and updates the respective local value with it
	///
	/// - Parameter isFeed: An instance of Bool 
	func updateFeedState(_ isFeed: Bool) {
		self.isFeedEnabled.update(isFeed)
	}
	
	func deleteEvent(atIndexPath indexPath: IndexPath) {
		guard let event: Event = fetchedEvents?[indexPath.row] else {
			return
		}
		
		do {
			try realm.write {
				realm.delete(event)
			}
		} catch (let error) {
			DLog("Error deleting Event from Realm: \(error.localizedDescription)")
		}
	}
	
	/// Returns a SelectedEventViewModel for transition to SelectedEventViewController
	///
	/// - Parameter _ index = The index that the event lives in the realm objects of type Event
	func createSelectedViewModel(_ index: Int) -> SelectedEventViewModel {
		return SelectedEventViewModel(event: events.value[index].event, activeAccount: activeAccount)
	}
	
	
	
}
