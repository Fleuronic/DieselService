// Copyright © Fleuronic LLC. All rights reserved.

extension Service: VenueSpec where
    API: VenueSpec,
    API.VenueList == Void,
    API.VenueStorageResult == APIResult<[VenueBaseFields]>,
    Database: VenueSpec,
    Database.VenueList == [VenueBaseFields] {
    public func storeVenues(from list: Void = ()) async -> APIResult<Database.VenueStorageResult> {
        await api.storeVenues(from: list).asyncMap(database.storeVenues)
    }
}
