// Copyright © Fleuronic LLC. All rights reserved.

public protocol AddressSpec {
	associatedtype AddressList
	associatedtype AddressStorageResult

	func storeAddresses(from list: AddressList) async -> AddressStorageResult
}
