// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Event

public protocol EventSpec {
    associatedtype EventList
	associatedtype EventListResult
	associatedtype EventDetailsResult
	associatedtype EventStorageResult
    associatedtype EventDeletionResult

	func listEvents(for year: Int) -> AsyncStream<EventListResult>
	func fetchEventDetails(with id: Event.ID) -> AsyncStream<EventDetailsResult>
    func storeEvents(from list: EventList, for year: Int) async -> EventStorageResult
    func deleteEvents(for year: Int) async -> EventDeletionResult
}
