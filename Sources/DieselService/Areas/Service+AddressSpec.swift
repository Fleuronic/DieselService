// Copyright © Fleuronic LLC. All rights reserved.

extension Service: AddressSpec where
	API: AddressSpec,
	API.AddressList == Void,
	API.AddressStorageResult == APIResult<[AddressBaseFields]>,
	Database: AddressSpec,
	Database.AddressList == [AddressBaseFields]
{
	public func storeAddresses(from list: Void = ()) async -> APIResult<Database.AddressStorageResult> {
		await api.storeAddresses(from: list).asyncMap(database.storeAddresses)
	}
}
