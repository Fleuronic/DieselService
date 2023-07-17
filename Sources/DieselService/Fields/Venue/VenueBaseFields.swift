// Copyright © Fleuronic LLC. All rights reserved.

import Schemata

import struct Diesel.Venue
import struct Diesel.Address
import protocol Identity.Identifiable

public struct VenueBaseFields {
	public let id: Venue.ID
    public let name: String
	public let addressID: Address.ID
}

// MARK: -
extension VenueBaseFields: VenueFields {
	// MARK: ModelProjection
	public static let projection = Projection<Venue.Identified, Self>(
		Self.init,
		\.id,
		\.value.name,
        \.address.id
	)
}

// MARK: -
extension VenueBaseFields: Decodable {
    public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: Venue.Identified.CodingKeys.self)
        id = try container.decode(Venue.ID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)

		let addressContainer = try container.nestedContainer(keyedBy: IDCodingKeys.self, forKey: .address)
		addressID = try addressContainer.decode(Address.ID.self, forKey: .id)
    }
}
