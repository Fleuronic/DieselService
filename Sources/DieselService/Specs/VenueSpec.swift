// Copyright © Fleuronic LLC. All rights reserved.

public protocol VenueSpec {
	associatedtype VenueList
	associatedtype VenueStorageResult

	func storeVenues(from list: VenueList) async -> VenueStorageResult
}
