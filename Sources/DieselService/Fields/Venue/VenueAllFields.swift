// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Venue
import struct Diesel.Address
import struct Diesel.Location
import protocol Identity.Identifiable

public struct VenueAllFields {
    public let id: Venue.ID
    public let name: String
    public let address: AddressAllFields
}

// MARK: -
extension VenueAllFields: VenueFields {
    // MARK: ModelProjection
    public static let projection = Projection<Venue.Identified, Self>(
        Self.init,
        \.id,
        \.value.name,
        \.address.id,
        \.address.value.streetAddress,
        \.address.value.zipCode,
        \.address.location.id,
        \.address.location.value.city,
        \.address.location.value.state
    )
}

// MARK: -
private extension VenueAllFields {
    init(
        id: Venue.ID,
        name: String,
        addressID: Address.ID,
        streetAddress: String,
        zipCode: String,
        locationID: Location.ID,
        city: String,
        state: String
    ) {
        self.id = id
        self.name = name

        address = .init(
            id: addressID,
            streetAddress: streetAddress,
            zipCode: zipCode,
            location: .init(
                id: locationID,
                city: city,
                state: state
            )
        )
    }
}
