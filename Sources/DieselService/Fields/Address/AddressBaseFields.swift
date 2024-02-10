// Copyright © Fleuronic LLC. All rights reserved.

import struct Diesel.Address
import struct Diesel.Location
import struct Catena.IDFields
import struct Schemata.Projection

public struct AddressBaseFields {
	public let id: Address.ID
	public let location: IDFields<Location.Identified>

	let streetAddress: String
	let zipCode: String
}

// MARK: -
extension AddressBaseFields: AddressFields {
	// MARK: ModelProjection
	public static let projection = Projection<Address.Identified, Self>(
		Self.init,
		\.id,
		\.location.id,
		\.value.streetAddress,
		\.value.zipCode
	)
}

// MARK: -
private extension AddressBaseFields {
	init(
		id: Address.ID,
		locationID: Location.ID,
		streetAddress: String,
		zipCode: String
	) {
		self.id = id
		self.streetAddress = streetAddress
		self.zipCode = zipCode

		location = .init(id: locationID)
	}
}
