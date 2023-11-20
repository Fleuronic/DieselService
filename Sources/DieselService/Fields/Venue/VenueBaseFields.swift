// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Address
import struct Diesel.Venue
import struct Catena.IDFields
import struct Schemata.Projection
import protocol Identity.Identifiable

public struct VenueBaseFields {
	public let id: Venue.ID
	public let name: String
	public let host: String?
	public let address: IDFields<Address.Identified>
}

// MARK: -
extension VenueBaseFields: VenueFields {
	// MARK: ModelProjection
	public static let projection = Projection<Venue.Identified, Self>(
		Self.init,
		\.id,
		\.value.name,
		\.value.host,
		\.address.id
	)
}

// MARK: -
private extension VenueBaseFields {
	init(
		id: Venue.ID,
		name: String,
		host: String?,
		addressID: Address.ID
	) {
		self.id = id
		self.name = name
		self.host = host

		address = .init(id: addressID)
	}
}
