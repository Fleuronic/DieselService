// Copyright © Fleuronic LLC. All rights reserved.

public protocol ShowSpec {
	associatedtype ShowList
	associatedtype ShowStorageResult

	func storeShows(from list: ShowList) async -> ShowStorageResult
}
