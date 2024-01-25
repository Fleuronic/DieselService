// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Address
import struct Diesel.Location
import struct Catena.IDFields
import struct Schemata.Projection
import protocol Identity.Identifiable

public struct AddressBaseFields {
	public let id: Address.ID

	let streetAddress: String
	let zipCode: String
	let location: IDFields<Location.Identified>
}

// MARK: -
extension AddressBaseFields: AddressFields {
	// MARK: ModelProjection
	public static let projection = Projection<Address.Identified, Self>(
		Self.init,
		\.id,
		\.value.streetAddress,
		\.value.zipCode,
		\.location.id
	)
}

// MARK: -
private extension AddressBaseFields {
	init(
		id: Address.ID,
		streetAddress: String,
		zipCode: String,
		locationID: Location.ID
	) {
		self.id = id
		self.streetAddress = streetAddress
		self.zipCode = zipCode

		location = .init(id: locationID)
	}
}
