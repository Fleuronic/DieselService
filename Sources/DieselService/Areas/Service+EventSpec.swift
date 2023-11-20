// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event

extension Service: EventSpec where
	Self: VenueSpec,
	Self: AddressSpec,
	Self: LocationSpec,
	API: EventSpec,
	API.EventList == Void,
	API.EventListResult == APIResult<[API.EventListFields]>,
	API.EventDetailsResult == APIResult<API.EventDetailsFields?>,
	API.EventStorageResult == APIResult<[EventBaseFields]>,
	Database: EventSpec,
	Database.EventList == [EventBaseFields],
	Database.EventListResult == DatabaseResult<[API.EventListFields]>,
	Database.EventDetailsResult == DatabaseResult<API.EventDetailsFields?>,
	Database.EventStorageResult == DatabaseResult<[Event.ID]>
{
	public func listEvents(for year: Int) -> AsyncStream<API.EventListResult> {
		.init { continuation in
			Task {
				let localEvents = await database.listEvents(for: year).value.value
				if !localEvents.isEmpty {
					continuation.yield(.success(localEvents))
				}
				
				let remoteEvents = await api.listEvents(for: year).value
				continuation.yield(remoteEvents)
				continuation.finish()
			}
		}
	}

	public func fetchEventDetails(with id: Event.ID) -> AsyncStream<API.EventDetailsResult> {
		.init { continuation in
			Task {
				let localDetails = await database.fetchEventDetails(with: id).value.value
				if let localDetails {
					continuation.yield(.success(localDetails))
				}
				
				let remoteDetails = await api.fetchEventDetails(with: id).value
				continuation.yield(remoteDetails)
				continuation.finish()
			}
		}
	}

	public func storeEvents(from list: Void = (), for year: Int) async -> APIResult<[Event.ID]> {
		await storeLocations().asyncFlatMap { _ in
			await storeAddresses()
		}.asyncFlatMap { _ in
			await storeVenues()
		}.asyncFlatMap { _ in
			await api.storeEvents(from: list, for: year)
		}.asyncMap { list in
			await database.storeEvents(from: list, for: year).value
		}
	}

	public func deleteEvents(for year: Int) async -> Database.EventDeletionResult {
		await database.deleteEvents(for: year)
	}
}
