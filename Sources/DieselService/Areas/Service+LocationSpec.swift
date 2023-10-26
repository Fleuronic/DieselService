// Copyright © Fleuronic LLC. All rights reserved.

extension Service: LocationSpec where
	API: LocationSpec,
	API.LocationList == Void,
	API.LocationStorageResult == APIResult<[LocationBaseFields]>,
	Database: LocationSpec,
	Database.LocationList == [LocationBaseFields] {
	public func storeLocations(from list: Void = ()) async -> APIResult<Database.LocationStorageResult> {
		await api.storeLocations(from: list).asyncMap(database.storeLocations)
	}
}
