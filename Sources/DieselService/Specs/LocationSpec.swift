// Copyright © Fleuronic LLC. All rights reserved.

public protocol LocationSpec {
	associatedtype LocationList
	associatedtype LocationStorageResult

	func storeLocations(from list: LocationList) async -> LocationStorageResult
}
