// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Address
import struct Diesel.Location
import protocol Identity.Identifiable

public struct AddressAllFields {
    public let id: Address.ID
    public let streetAddress: String
    public let zipCode: String
    public let location: LocationAllFields
}

// MARK: -
extension AddressAllFields: AddressFields {
    // MARK: ModelProjection
    public static let projection = Projection<Address.Identified, Self>(
        Self.init,
        \.id,
        \.value.streetAddress,
        \.value.zipCode,
        \.location.id,
        \.location.value.city,
        \.location.value.state
    )
}

// MARK: -
private extension AddressAllFields {
    init(
        id: Address.ID,
        streetAddress: String,
        zipCode: String,
        locationID: Location.ID,
        city: String,
        state: String
    ) {
        self.id = id
        self.streetAddress = streetAddress
        self.zipCode = zipCode
        location = .init(
            id: locationID,
            city: city,
            state: state
        )
    }
}
